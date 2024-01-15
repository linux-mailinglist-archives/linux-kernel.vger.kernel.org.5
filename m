Return-Path: <linux-kernel+bounces-26161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC54782DC23
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CA21C21C98
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88491773B;
	Mon, 15 Jan 2024 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="ivOIVkua"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505CD175BC;
	Mon, 15 Jan 2024 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4TDFlM3j27z682N;
	Mon, 15 Jan 2024 16:03:43 +0100 (CET)
Received: from andreas.got.gaisler.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4TDFlL6fwbz684C;
	Mon, 15 Jan 2024 16:03:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1705331023;
	bh=Jog/6l9wpG5kcq5vzlSYJw0qZn+FuN/TfkcrgXiXh/k=;
	h=From:To:Cc:Subject:Date;
	b=ivOIVkua9EUNpdDm7eB+ypmrepjloseZHBcXIOiHzZUI9UPpKgC+4Or9Ay7V2ydny
	 +Dt9G1Mu4n3eUjTb3XIjcoILHEQu44dboW8uZnT4Zc4+NWkfTXoVuRXnL2CvAR47Py
	 t5OZusX9Xld3Qmm7y5wrQeK9Z/shMwheO1Wg1r6g=
From: Andreas Larsson <andreas@gaisler.com>
To: David Miller <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org,
	software@gaisler.com
Subject: [PATCH] MAINTAINERS: Add Andreas Larsson as co-maintainer for arch/sparc
Date: Mon, 15 Jan 2024 16:02:00 +0100
Message-Id: <20240115150200.513531-1-andreas@gaisler.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dave has not been very active on arch/sparc for the past two years.
I have been contributing to the SPARC32 port as well as maintaining
out-of-tree SPARC32 patches for LEON3/4/5 (SPARCv8 with CAS support)
since 2012. I am willing to step up as an arch/sparc (co-)maintainer.

For recent discussions on the matter, see [1] and [2].

[1] https://lore.kernel.org/r/20230713075235.2164609-1-u.kleine-koenig@pengutronix.de
[2] https://lore.kernel.org/r/20231209105816.GA1085691@ravnborg.org/

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 391bbb855cbe..9e12c8cdbef0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20431,6 +20431,7 @@ F:	Documentation/translations/sp_SP/
 
 SPARC + UltraSPARC (sparc/sparc64)
 M:	"David S. Miller" <davem@davemloft.net>
+M:	Andreas Larsson <andreas@gaisler.com>
 L:	sparclinux@vger.kernel.org
 S:	Maintained
 Q:	http://patchwork.ozlabs.org/project/sparclinux/list/
-- 
2.34.1


