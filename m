Return-Path: <linux-kernel+bounces-11496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD49781E741
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC181F22619
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96F14EB2B;
	Tue, 26 Dec 2023 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFjTyeKD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC404E61F;
	Tue, 26 Dec 2023 12:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A75AC433C7;
	Tue, 26 Dec 2023 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703592654;
	bh=ALlrmlO3TZ8rTcppMu1Ow9TnWlk/ALtcHvbxxjlX0po=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fFjTyeKDINGIZSjYwg0UTPejQCfOsa6UICttivZtcnkY1Hz9q5gG9t5FfyqlbGTK8
	 B5LVgY5VR86jCz1TGmA2ScQxFkRJz8PMFkOqps5pmAhXyLRrTTgxEIw6ys+yWZgI3T
	 wEaJKs8eFJBIS4hhtvvl8mzryIvH22vPvxeA1ibTZh4xk/MjB0y6zOShrdZ/llvjtM
	 gaahBmudb4B0ofLNM374p1I0HVsICySrL0H0leoCFHxoSj65+hWQUdH3oEX3rXcEjv
	 Y4mwKAynNNA3taQFMKuk4YUAlQc9vM10nHbWcNwJN52hYa7KQvGlBArcxRuD1M+WVB
	 phaK6y4FfWlxQ==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 26 Dec 2023 13:10:17 +0100
Subject: [PATCH net 1/2] MAINTAINERS: add Geliang as reviewer for MPTCP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231226-upstream-net-20231226-mptcp-prevent-warn-v1-1-1404dcc431ea@kernel.org>
References: <20231226-upstream-net-20231226-mptcp-prevent-warn-v1-0-1404dcc431ea@kernel.org>
In-Reply-To: <20231226-upstream-net-20231226-mptcp-prevent-warn-v1-0-1404dcc431ea@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=815; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ALlrmlO3TZ8rTcppMu1Ow9TnWlk/ALtcHvbxxjlX0po=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlisLJrh3/+s08oTpRIE5WrYCb3GUarK/E3+Tje
 3iKYPL/YcGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZYrCyQAKCRD2t4JPQmmg
 c9I6EAC+BvQNdxnlaIk2nBosBJtJDkLuxLBY09t/O329mNv5teZImovDb+4GlIGkNI7dz8Zgz1F
 WXrGdY+VfO7O/z6H4m+ZDIH4WDX7KvVAkIaAU2PYLJZANWxB/SkZs2qrOLsgTZYi+Pkul5cqcvc
 Z/x3NeJc7Q9vzZtr2onJ38oRA8kcqgZJ6PzBhVjxfyfsgppD4TDW9fqUIeiNAp0E/5eN6QUhiiQ
 /PYU7CaKqc1uS82H2yqCk4wGtTF5YWXI/ZSfGOSad6l9fPG8ux9Gfe5nDLOrFn0kT6vEJzld5rF
 VNkW+uLdGumFG6iReGzvqjYpvnyYak2rJTpiqpYtRA3lG0nyGvhhF82LHRR6C2b19Y+pEyW+mId
 A8dzQWphf7gjreg/LkuO1hFNfoTxChKSty/FmB9ZwhPBLSN1Mu5uRr15MrB2ZiUhCsfyUAzTwne
 IrjzZthKAq4se6crhki7VExTmcJivaSlBf+Be1Oqagb21WXTtXZ4WqE9ePEOlwlaTlC9CpSRJqw
 ZaYZGtn0K20/qi7nj7ySuoteDzhAqgXNrVamlYKP0xWZxb11/LZvx7iF8fAYuriMJ7taST1+7Jv
 /3KcH7NJ9Ey8lcz34pgyFbgkn085Girc05hhqF/7mYRRme6YLGO4g7Zka7NH9+yxRF+L2g4j96P
 d0f61lpAhdEDpXg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

For a long time now, Geliang has contributed to a lot of code and
reviews related to MPTCP. So let's reflect that in the MAINTAINERS file.

This should also encourage patch submitters to add him to the CC list.

Acked-by: Geliang Tang <geliang.tang@linux.dev>
Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7cef2d2ef8d7..cc9e2dc4ad9a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15078,6 +15078,7 @@ K:	\bmdo_
 NETWORKING [MPTCP]
 M:	Matthieu Baerts <matttbe@kernel.org>
 M:	Mat Martineau <martineau@kernel.org>
+R:	Geliang Tang <geliang.tang@linux.dev>
 L:	netdev@vger.kernel.org
 L:	mptcp@lists.linux.dev
 S:	Maintained

-- 
2.43.0


