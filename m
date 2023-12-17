Return-Path: <linux-kernel+bounces-2726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E652581610A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23EFC1C22023
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F9156758;
	Sun, 17 Dec 2023 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWmLv4sF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB455C2D;
	Sun, 17 Dec 2023 17:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6EAC433C8;
	Sun, 17 Dec 2023 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833727;
	bh=6xX0NS0k5hxBgxqWrSvbVm7UwlJvA2gi/kLBPb67Z08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cWmLv4sF4bVtY6P5wZ/Cz08liy5BL7qofGo+Y2K1/9D5GgXtzR3kvghZxF1hQKu+f
	 syYAa7FE+OHQnIgtGYQuRBqyb6FK8Nms3dSN+KpuLsJBWlPKFpmkOV7c110Dwgj8Pb
	 UwJS2/RuTIObygwaPp5CYa37XXBSfAhMIx1q38hb4m12PL1WBfae9vh6iIXtGkWHv/
	 E2vGXfUtTbIKvJ5jDqdvc/Ue5jcLEB3KnIe5x4l415UrN66mIEIXORlj0efcpCzBev
	 rpfRL2CqiLgEThOZwonU88dBuBU+HAbN4kFpacRrWQEIJc4628yOXps2Q7QAeR9K40
	 AnJ1OL7MfaW8w==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: add fastrpc-compute-cb nodes
Date: Sun, 17 Dec 2023 11:21:20 -0600
Message-ID: <170283349435.66089.9986656057477418932.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215-topic-sm8650-upstream-dt-fastrpc-v1-1-5016f685ab5a@linaro.org>
References: <20231215-topic-sm8650-upstream-dt-fastrpc-v1-1-5016f685ab5a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 15 Dec 2023 12:45:53 +0100, Neil Armstrong wrote:
> Add the missing aDSP and cDSP fastrpc compute-cb nodes for the SM8650 SoC.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8650: add fastrpc-compute-cb nodes
      commit: b0fd89bc1aeca3bb9cfccd1cadf4cbd31f8e8a19

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

