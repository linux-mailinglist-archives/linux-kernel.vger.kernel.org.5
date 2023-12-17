Return-Path: <linux-kernel+bounces-2811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5432E816249
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2ACD280C92
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FAA48CDA;
	Sun, 17 Dec 2023 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKXdpEHu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC2482C7;
	Sun, 17 Dec 2023 21:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCA2C433C9;
	Sun, 17 Dec 2023 21:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702847170;
	bh=1GHVArQI/I2o104sYcABaTbfwOYpIu7WAXvx1z3OIGI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LKXdpEHuVNem/xKInFYGeoPwEr1DxPwV587tmcsNryhgaCdfir2nUbQjibPkc3OV+
	 JnpTgBZ0C4hzSIkn+Zt+P4bWDcK7ry/hhvQR7rYctfx5O4cssUXeUioyxGVqnadr4e
	 0RUpNigzshaWiN4x9mxj6MQ/XIAcHrotPed86djMD/uedsB/z/Ud3S/DnrZflrqOVe
	 AMvgA1fPqa6goQpWZTZqplnGSX3+2Xl3BsJDXK0f9V+2tA0OGdPeUALz8tJWDXEQfk
	 n1WLhHZga/BwKI4xZLMJsxIl3vAKpz95zhgId6YCYMN91Pu5beTAxfj+ucLOz0agdb
	 0EkyKC/lhHOGg==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND] arm64: defconfig: enable newer Qualcomm sound drivers
Date: Sun, 17 Dec 2023 15:06:06 -0600
Message-ID: <170284716297.78529.7971341363459719102.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106073048.24553-1-krzysztof.kozlowski@linaro.org>
References: <20231106073048.24553-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 06 Nov 2023 08:30:48 +0100, Krzysztof Kozlowski wrote:
> Enable the sound machine driver for Qualcomm SC8280xp soundcard (used on
> Lenovo Thinkpad X13s laptop), Qualcomm WSA883x (speakers on X13s) and
> Qualcomm WSA884x (speakers on boards with Qualcomm SM8550 like QRD8550).
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: enable newer Qualcomm sound drivers
      commit: 48a9ba5eb4d720c6e21c6e4d2a6fb6e1a97f5f2a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

