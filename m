Return-Path: <linux-kernel+bounces-2710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D608160DB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A876BB220CC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD2F4AF93;
	Sun, 17 Dec 2023 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBHEp/t7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B137C4A98C;
	Sun, 17 Dec 2023 17:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFF4C433C7;
	Sun, 17 Dec 2023 17:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833709;
	bh=sRjNsixVfdlgg1JXGRRXkSRZ6uJObgQiDCSw7NrCMsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBHEp/t7STlWDwDDZGbGEOzj7q2ihS633C7mQ1cLyyEvy8+RGonwtfsWJ9N/UCVo1
	 /7v+cL62kuOm7vqABntMKBYEYiWDkI/NotE7IPKH8o4DiqbXqvRmB++gXW81+SGoRy
	 K4e80ArSGAzsozq9D3oa4bEhSliM44j/ngyDnz2xUEffHSdUMln192ggdjN5LmTbGX
	 4TrnzjNgDMpwMb42H2C1DpaJpleSOqiHstfkl2HD1qJAL8H7GXTQ6RsiV12YumiiYY
	 i3INujpdxDaGVfZ5pF4xfhd2RaL5kbx5ca+gfoa+jvhPw3dKLRbrSMbd1RxxxvTm0k
	 0ql1DSG7raVCw==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 0/2] ARM: dts: qcom: msm8926-motorola-peregrine: Add initial device tree
Date: Sun, 17 Dec 2023 11:21:04 -0600
Message-ID: <170283349432.66089.8491386474917760370.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214-peregrine-v2-0-a35102268442@apitzsch.eu>
References: <20231214-peregrine-v2-0-a35102268442@apitzsch.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Dec 2023 21:59:32 +0100, André Apitzsch wrote:
> This dts adds support for Motorola Moto G 4G released in 2013.
> 
> Add a device tree with initial support for:
> 
> - GPIO keys
> - Hall sensor
> - SDHCI
> - Vibrator
> 
> [...]

Applied, thanks!

[2/2] ARM: dts: qcom: msm8926-motorola-peregrine: Add initial device tree
      commit: 690e367e0e75a46a0b3d76ae42a14f7f31f451dd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

