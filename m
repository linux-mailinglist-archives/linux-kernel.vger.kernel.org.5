Return-Path: <linux-kernel+bounces-34173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C08837517
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12FB1C24927
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AC3481B3;
	Mon, 22 Jan 2024 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwlOHcpq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01AC481AD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958118; cv=none; b=HFpwC7J3r2753rpUzoPbTMxzVQu9YlQGI6NydpnK7Xn78Iv5T9GqPrk0fky47B63rCEtfVlSBgr6z3Mtb06tv70U+tRTA3pKBm0aD7E+D6ufhh1+UA+3YAli4Uks+psykXQlIhEqG36fY0WWLW4ImiPv9TkcQgMiLteRWT5iL8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958118; c=relaxed/simple;
	bh=6ujvhevZE8aH8oCBFWmXxBC74lT8VSsDEBhApVvjmCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZkBtYYg/Wpec9SBRnaF59aIpJN/G36uf7VVT6ICUW4ZuYi6nXhVe/jqvbJpCZtGLB81ZAwrWtJwIidebLEFFJfY41o42rEUBlqmCTJLGisANy1S4mgGIeEeART0Y4yEB/gh34UGBhDbgZ9W6tERuVjjPqhkfzE1zi6Nydtg6M4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwlOHcpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3180EC433F1;
	Mon, 22 Jan 2024 21:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705958117;
	bh=6ujvhevZE8aH8oCBFWmXxBC74lT8VSsDEBhApVvjmCQ=;
	h=From:To:Cc:Subject:Date:From;
	b=bwlOHcpqAOIvfCu/T2HVJedSesIefMZxez6ysV3jEzL++kqxzdWEw3lqX4vDevDHx
	 vwDkJDrujljylyo4nmcpvGYJk4WT6bVkJEwjVCXaDlWC485IQ8rGu9WVDjFwNSz3pQ
	 0OloJk6oIENsAFyPRrGFECVzf8tVBAtCnEIgBj457XeuMFI2rCVkyRL2Eb8XupqvHq
	 dRk5PbgeYijWfMF914XPDzXBT9bpog88wp/xxd9y7zfcCrxpND9Y2+XxoWMX6dg9FR
	 ldZB2569mkxHc9B7C40EBqdnQMJKqlfZfIqCPIoc5uwBSkjhAa7lOfrZlO+bcIEBmu
	 XgeVTawBPSRjg==
From: Rob Herring <robh@kernel.org>
To: Frank Rowand <frowand.list@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Drop Frank Rowand from DT maintainership
Date: Mon, 22 Jan 2024 15:15:00 -0600
Message-ID: <20240122211501.1719374-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Frank retired a while back and surprisingly has found better things to
do than DT maintainership. Thank you Frank for all of your help with DT
for many years.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..eda745c0f92a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16359,7 +16359,6 @@ F:	drivers/infiniband/ulp/opa_vnic
 
 OPEN FIRMWARE AND FLATTENED DEVICE TREE
 M:	Rob Herring <robh+dt@kernel.org>
-M:	Frank Rowand <frowand.list@gmail.com>
 L:	devicetree@vger.kernel.org
 S:	Maintained
 W:	http://www.devicetree.org/
-- 
2.43.0


