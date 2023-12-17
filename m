Return-Path: <linux-kernel+bounces-2706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35158160C6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9A31F22929
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBF9481BB;
	Sun, 17 Dec 2023 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPBWiuTL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F884481A2;
	Sun, 17 Dec 2023 17:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EEAC433C8;
	Sun, 17 Dec 2023 17:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833701;
	bh=0fkvDAe5l42RoSldVuYfFuGOt2H02fESfWY0fe3Bz0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPBWiuTLGH3kVWBaI0+OH0HL/WdA0ziLIHb/hR6Xn50rnYCySrNxGqgYkhGKGyIXf
	 LZ8yQK3YpwN/X+fPwxQPYgwuGXmaOVyuKmyMLWldpxY7VTXlERJVa26oV9y2QAFD3D
	 4qHr95V7iR+bJ8bq7U/BbwsTJKNa84WItWoT02kafLBan9xHes5tAB6Eo4s4wLZQ0O
	 GkwzE7oDepuPLRdTr0bFQ5DnFOCOAlPXmvlcFLfIQ4em7E8czMU+CuT3zb0PeKarga
	 IZ5rTEUTjyJf6wSVxvqEdxyd2d2SN1JwSzOZieG0M9aEITp2ZyxPBBuvUROmMwiBef
	 odQnioZET1P4g==
From: Bjorn Andersson <andersson@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/1] arm64: dts: qcom: ipq6018: Add remaining QUP UART node
Date: Sun, 17 Dec 2023 11:20:57 -0600
Message-ID: <170283349408.66089.14585094116321497204.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231203153914.532654-1-amadeus@jmu.edu.cn>
References: <20231203153914.532654-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 03 Dec 2023 23:39:14 +0800, Chukun Pan wrote:
> Add node to support all the QUP UART node controller inside of IPQ6018.
> Some routers use these bus to connect Bluetooth chips.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq6018: Add remaining QUP UART node
      commit: e6c32770ef83f3e8cc057f3920b1c06aa9d1c9c2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

