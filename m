Return-Path: <linux-kernel+bounces-10214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9D181D154
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9980E284DA8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EBD17C9;
	Sat, 23 Dec 2023 02:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9GOsjlN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ABE1375;
	Sat, 23 Dec 2023 02:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80BFC433C7;
	Sat, 23 Dec 2023 02:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703300280;
	bh=M9ylAFnRe9aeRWDSKhlVrcGAk2FuFB8Vu0oISB/3HR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9GOsjlNOxFOJGIR1kF+TgIAym9ldH5oDU2GZ4MiYu9xODdYdP7vHMsaYFwByTHYh
	 /3HvmPJCCqJTP1OpZvKh7dproq9f4fY6llNOsxDJfaX15OFo7Xw23mS3uayi89o3wH
	 8MQHHzCVjBH2hPKX4HZhJHGL2kpIi2ga1XSSlgjA2QftLPmmOhqR3kq5b0Sy+2SUgV
	 yt3uyTclCjIWqMv0nsYrbwYeEeKh9oiXeGJshvOCW+AiSWa2ApFD8luTjtH2cs3Q74
	 a9ZY3bus38AaxSCbOoX4awOlEQA+ZmFdETBJvDQcjH2FVLOCS3sgLhgAI4dPTSMfal
	 9EflcenhnGsOQ==
Date: Fri, 22 Dec 2023 20:57:56 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: agross@kernel.org, konrad.dybcio@linaro.org, linus.walleij@linaro.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] pinctrl: qcom: sm4450: dd SM4450 pinctrl driver
Message-ID: <doyw6yadl2u3u7e4co5oz2sibq7ncmtuncjvxwqlh3t5yeuw42@niiufdcxzawh>
References: <20231206020840.33228-1-quic_tengfan@quicinc.com>
 <20231206020840.33228-3-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206020840.33228-3-quic_tengfan@quicinc.com>

On Wed, Dec 06, 2023 at 10:08:40AM +0800, Tengfei Fan wrote:
> Add pinctrl driver for TLMM block found in SM4450 SoC.
> Can Guo helped out in reviewing the driver.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

