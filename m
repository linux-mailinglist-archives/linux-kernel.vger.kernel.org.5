Return-Path: <linux-kernel+bounces-23470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD7082AD3D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8986F2880A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4695D15483;
	Thu, 11 Jan 2024 11:20:31 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF31A14F88;
	Thu, 11 Jan 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [113.118.191.185])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 3481B8000CD;
	Thu, 11 Jan 2024 19:20:07 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: krzysztof.kozlowski@linaro.org
Cc: amadeus@jmu.edu.cn,
	andersson@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	konrad.dybcio@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: ipq6018: enable sdhci node
Date: Thu, 11 Jan 2024 19:20:01 +0800
Message-Id: <20240111112001.124246-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4b114b3b-468c-4759-bb32-9afeac9d5608@linaro.org>
References: <4b114b3b-468c-4759-bb32-9afeac9d5608@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHk8dVkxPHU9MSkwYQkgdSFUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSFVKSkNVSkJKVUpDTllXWRYaDxIVHRRZQVlLVUtVS1VLWQY+
X-HM-Tid: 0a8cf8403859b03akuuu3481b8000cd
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6Dio4ODwvDC83Ax5ROBgR
	ERVPChdVSlVKTEtPQkxJS0tDSUNKVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	SFVKSkNVSkJKVUpDTllXWQgBWUFKT05JNwY+

> ? What is a general property? I repeat my question - these do not look
> SoC specific, but board.

Sorry, I understood it wrong. I will remove the 1.8v properties
in the next patch.

Thanks,
Chukun

-- 
2.25.1


