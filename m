Return-Path: <linux-kernel+bounces-23014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C15582A65B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5C728B3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4053ED6;
	Thu, 11 Jan 2024 03:10:47 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E042A15C2;
	Thu, 11 Jan 2024 03:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [113.118.191.185])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 14CC080007F;
	Thu, 11 Jan 2024 11:10:30 +0800 (CST)
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
Date: Thu, 11 Jan 2024 11:10:26 +0800
Message-Id: <20240111031026.2175521-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4f070678-63b6-4657-ad4f-c32256adbf1f@linaro.org>
References: <4f070678-63b6-4657-ad4f-c32256adbf1f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTENPVkxNGRpNGR8ZH01NHlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSFVKSkNVSkJKVUpDTllXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Tid: 0a8cf67ff5d9b03akuuu14cc080007f
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngw6EDo*KzwiDCkcFR4pIR5L
	PFFPCz5VSlVKTEtPQk9JTUhKSUNMVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	SFVKSkNVSkJKVUpDTllXWQgBWUFKQ05DNwY+

On 10/01/2024 16:10, Chukun Pan wrote:
> Changes from v2:
> * arm64: dts: qcom: ipq6018: add LDOA2 regulator
> No Changes:
> * arm64: dts: qcom: ipq8074: add MicroSD node

I wrote it wrong in cover-letter, it's ipq6018, not ipq8074.
No Changes:
  arm64: dts: qcom: ipq6018: enable sdhci node

On 10/01/2024 16:22, Krzysztof wrote:
> How? It is disabled...

Disable it because not all devices have eMMC or MicroSD connected.
I enabled it on the dts of the device and tested it on my ipq6000.

> Aren't these three properties of the board?

These are just general properties.

Thanks,
Chukun

-- 
2.25.1


