Return-Path: <linux-kernel+bounces-5877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FBE8190DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368951F25F87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8153D0A7;
	Tue, 19 Dec 2023 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxmItlhk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F43C48B;
	Tue, 19 Dec 2023 19:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131A1C433A9;
	Tue, 19 Dec 2023 19:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703014427;
	bh=R8aLKmqJ+OMNSwbGLMJz+7zw9zSZQpgACL9zmsmWWaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxmItlhkKGwUiLgz+OkIdW3KmRsIdNvnPVYDe287svxIZsfpGaWyaCQcB/bMcnfUT
	 d+TJhZxzAHm09OMBy1ruKyjsWsSbFcJFVguimAzwyDKg9+ncs4eoiCFn6DyFu9METD
	 VtOdQLcm0icr8zsGQUOKTmqnYCtDj5TTNO9gmzEqsXTf5lOSJeh1U1uCJO0GA2KVz/
	 a/hIixcGNp2ZKixZHeuSwv1KQmnohQaI6vmdnixcMJBIEnGm/QpfqrCXV56pIA9k5K
	 rUv0+WZc65GVp7HXwrv6IYzVETwad4tvAfRtgSJwEgqzGWlHaOik7+XZAeALwEcaAw
	 UxTHgViG0nD6A==
From: Bjorn Andersson <andersson@kernel.org>
To: cros-qcom-dts-watchers@chromium.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Mark SDHCI hosts as cache-coherent
Date: Tue, 19 Dec 2023 13:33:32 -0600
Message-ID: <170301441246.365364.17132243970310144948.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231218-topic-7280_dmac_sdhci-v1-1-97af7efd64a1@linaro.org>
References: <20231218-topic-7280_dmac_sdhci-v1-1-97af7efd64a1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 18 Dec 2023 15:38:33 +0100, Konrad Dybcio wrote:
> The SDHCI hosts on SC7280 are cache-coherent, just like on most fairly
> recent Qualcomm SoCs. Mark them as such.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Mark SDHCI hosts as cache-coherent
      commit: 827f5fc8d912203c1f971e47d61130b13c6820ba

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

