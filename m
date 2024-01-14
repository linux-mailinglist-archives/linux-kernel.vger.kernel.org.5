Return-Path: <linux-kernel+bounces-25422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FA082D009
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 09:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062D01C20BC1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 08:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271641FB4;
	Sun, 14 Jan 2024 08:49:23 +0000 (UTC)
Received: from mail-m25481.xmail.ntesmail.com (mail-m25481.xmail.ntesmail.com [103.129.254.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B68186B;
	Sun, 14 Jan 2024 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [113.118.191.185])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id C8CCE800080;
	Sun, 14 Jan 2024 16:30:38 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: konrad.dybcio@linaro.org
Cc: amadeus@jmu.edu.cn,
	andersson@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robimarko@gmail.com
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: ipq6018: add LDOA2 regulator
Date: Sun, 14 Jan 2024 16:30:35 +0800
Message-Id: <20240114083035.10410-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b64a5650-6152-4a66-81c1-22df2abfe359@linaro.org>
References: <b64a5650-6152-4a66-81c1-22df2abfe359@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0xOVkhLTE9KT05DTEpDHVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSFVKSkNVSkJKVUpDTllXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Tid: 0a8d071823e9b03akuuuc8cce800080
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgg6PBw4NzwpKiIUCxFPLBg5
	Ai0aCyNVSlVKTEtOSUlKS0hCTUtLVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	SFVKSkNVSkJKVUpDTllXWQgBWUFKSEpONwY+

> Why is is always-on?

No need, I will remove it in the next patch.

Thanks,
Chukun

-- 
2.25.1


