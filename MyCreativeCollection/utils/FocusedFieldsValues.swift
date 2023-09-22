//
// MyCreativeCollection
// Created by: itsjagnezi on 05/09/23
// Copyright (c) today and beyond
//

import Foundation

enum FocusedField: Hashable {
	case password,
			 confirmPassword,
			 usernameOrEmail,
			 passwordInvisible,
			 passwordVisible,
			 name,
			 username,
			 email
}
