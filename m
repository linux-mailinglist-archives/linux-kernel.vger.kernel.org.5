Return-Path: <linux-kernel+bounces-121766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE5B88EDB2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1126FB2AA3A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AD114D71B;
	Wed, 27 Mar 2024 17:53:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0662612E1D0;
	Wed, 27 Mar 2024 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561994; cv=none; b=EmXFmyrzZ5ls4Mvx2jj25o6j7fneqPXn7SFRZ2DDQS9F6VFySzmtxJCK33kOnHQDBYXU4//sqx1nvZmiKo+74kn+OrrJACcaUWYvNMqwCvwTccx3c0Xfx4tVWmc8gsUvGpTyFtXuGBtz0Pu851Fwab38Bu9bQ8ffISzxLDF2mzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561994; c=relaxed/simple;
	bh=hXb1CTWrSFa+2qFe1nAAZo3k5Ya1fVoQVEhBY8rhylQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=WLy9u9GJvt8knz50J3TeYZep0dXXJYmVW666YFf6ZnvrrhwwFZarPX35Qttm57+V6II4GXm+rl8UN+SqwDV3ZsjwpAbheEhFDvYJmvHCt2pm5KKRGHHKuqZKGwnPIjmEA4DIOBVCoVFoowNFmgiDs2hGsLKevEeb0IP5rOxww7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E990CC433C7;
	Wed, 27 Mar 2024 17:53:11 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: phy: MAINTAINERS: mark Freescale USB PHY as orphaned
Date: Wed, 27 Mar 2024 18:53:08 +0100
Message-Id: <20240327175308.520317-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emails to the only maintainer bounce:

  <ran.wang_1@nxp.com>: host nxp-com.mail.protection.outlook.com[52.101.68.39]
  said: 550 5.4.1 Recipient address rejected: Access denied.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51d5a64a5a36..b66812e99caf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8760,10 +8760,9 @@ S:	Maintained
 F:	drivers/usb/gadget/udc/fsl*
 
 FREESCALE USB PHY DRIVER
-M:	Ran Wang <ran.wang_1@nxp.com>
 L:	linux-usb@vger.kernel.org
 L:	linuxppc-dev@lists.ozlabs.org
-S:	Maintained
+S:	Orphan
 F:	drivers/usb/phy/phy-fsl-usb*
 
 FREEVXFS FILESYSTEM
-- 
2.34.1


