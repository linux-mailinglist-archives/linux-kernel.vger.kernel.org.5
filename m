Return-Path: <linux-kernel+bounces-5909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA60819160
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22CE1C244A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23C93A1A6;
	Tue, 19 Dec 2023 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJpX8vSc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D868839AEE;
	Tue, 19 Dec 2023 20:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934CCC433C8;
	Tue, 19 Dec 2023 20:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703017696;
	bh=RtkuChny9ze4o67EkIR09L7axpe3ka3cbmxgw31CuvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jJpX8vScbuC6HdLcIXSWyuiEoEK3rbOUsnsCUP53TfDrx69UjPKda8uG0p+L2CiWK
	 nR2BnHYR5GYQ9NFidSKT2xC5s7ZQE+5OLqj2Y3Lw6JP/4/eifTsW/xYH5amjG62LxQ
	 k3qtlxmsfAmKPl4qsXNJxwN4V4x+D3woP8VpNRVNSrjKk4K0jnystMzv7l0ejeiIO2
	 M2kEpFUZTnwSv/bTLTujGw8EHxZabR+LX+17zf+IfgtNMKpJda/sKfaLxuxW0HYBPh
	 lh9Svb4NjP3yQcL+d9lL7OFLtm5RacenFws7dMAesMCzHPONhZSG2IK4Hc3SSswFqG
	 y4YHwRzDyy1iQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x: Fix up PCIe nodes
Date: Tue, 19 Dec 2023 14:28:11 -0600
Message-ID: <170301768800.369406.2378531809103267970.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231219-topic-8180_pcie-v1-1-c2acbba4723c@linaro.org>
References: <20231219-topic-8180_pcie-v1-1-c2acbba4723c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 19 Dec 2023 14:05:06 +0100, Konrad Dybcio wrote:
> Duplicated clock output names cause probe errors and wrong clocks cause
> hardware not to work. Fix such issues.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8180x: Fix up PCIe nodes
      commit: 8e694a8903c9585c8dd59cdfbae66748f9234af0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

