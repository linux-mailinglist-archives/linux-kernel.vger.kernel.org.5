Return-Path: <linux-kernel+bounces-5910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA1C819163
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D78EBB252D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24323B190;
	Tue, 19 Dec 2023 20:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2yZvGCx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AE53A1B5;
	Tue, 19 Dec 2023 20:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84EDC433D9;
	Tue, 19 Dec 2023 20:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703017697;
	bh=8wxlvlYiQthJXZvgAvUlpHL6jIjtANgJ24VWyFdgsdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s2yZvGCxfm+VCSW1vdJUhjRTKcSK73yfTY7ZWvvuiRWbVDICl4TD9CiZCAjsHUi6B
	 vmEOhSODJRnTKA53N5Hqn+YoWRkWkBhHEf446lrk/oq95iK6KjJuZMtrNCrNh/QxfC
	 26YSLFj5vrevsM/w3KC50uvizykRPHl5/sR8M5YaTQkpguIUixlSiPU09O3G47V6Fr
	 kCtUL9q7V3jZH4ZWzN+B3P6pwjAm9MpJh5mTTXuWLJSXCwcJq6Jr1z4i7Ase9DOcQz
	 Da80Tnis7WVRq4lV8bAgJe7kZgFLY5Oxf6qug5i0NR6rgnf+DAPtG4cySldWI1b79p
	 3JXGEAA1hBJ2w==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x: Mark PCIe hosts cache-coherent
Date: Tue, 19 Dec 2023 14:28:12 -0600
Message-ID: <170301768800.369406.17873816919299729429.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231219-topic-8180_pcie_dmac-v1-1-5d00fc1b23fd@linaro.org>
References: <20231219-topic-8180_pcie_dmac-v1-1-5d00fc1b23fd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 19 Dec 2023 19:40:21 +0100, Konrad Dybcio wrote:
> The PCIe controllers on 8180 are cache-coherent. Mark them as such.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8180x: Mark PCIe hosts cache-coherent
      commit: 1b3319e8055f7b18bdc0fae0fa7847b905c38bb6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

