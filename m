Return-Path: <linux-kernel+bounces-2734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09574816122
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4D51C212ED
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1F15B5BD;
	Sun, 17 Dec 2023 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab0ugoX2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226825AB83;
	Sun, 17 Dec 2023 17:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281B8C433D9;
	Sun, 17 Dec 2023 17:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833740;
	bh=8PQ3fsTQHtLukUzVf7vlZms+8J8Avg1Hr4DWONOKJMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ab0ugoX29TeG7HAqPGhb6Nfo55IaLIdYOLNHzjsX0Kjw/hT2CHFH4UgFBvGlgjvrA
	 ozbNJV9ZPRY3vaR7lPR3pX2N0dwm6A5pT6ocC2+DRn22BUuX9rhO3O5YRdrHdaNN04
	 D8Dik6mB0stPkznL7lWWem/H0/sxeJmUXFFCPeDPHpZkrOXvDIv9cjhiGSZwgBkazx
	 PRL7dy9RaD9EbJV0GjeccsuqZf4OhQ1PzluzLzniYcoqtFz8a5u18JPLN+BLGOdZFc
	 c0wD3Wtc7xfdxXRarYVniTfbjdC+W+H3L0sH95Eo0nHnUZ986QVWsR3rel7BitX/x6
	 ppwMLysuze22A==
From: Bjorn Andersson <andersson@kernel.org>
To: agross@kernel.org,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Tengfei Fan <quic_tengfan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@quicinc.com
Subject: Re: (subset) [PATCH v7 0/6] soc: qcom: Add uart console support for SM4450
Date: Sun, 17 Dec 2023 11:21:28 -0600
Message-ID: <170283349405.66089.4031601862352845815.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129103325.24854-1-quic_tengfan@quicinc.com>
References: <20231129103325.24854-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 29 Nov 2023 18:33:19 +0800, Tengfei Fan wrote:
> This series add base description of UART, TLMM, RPMHCC, GCC and RPMh PD
> nodes which helps SM4450 boot to shell with console on boards with this
> SoC.
> 
> 

Applied, thanks!

[6/6] arm64: defconfig: enable clock controller and pinctrl
      commit: cdd97e07e5fa6babc8f620951efa517a1e29d6e2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

