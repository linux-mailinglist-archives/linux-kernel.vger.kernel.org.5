Return-Path: <linux-kernel+bounces-1580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4B9815067
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168641F25650
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0F041870;
	Fri, 15 Dec 2023 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peQ01X6N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B694184B;
	Fri, 15 Dec 2023 19:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2364CC433C7;
	Fri, 15 Dec 2023 19:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702669967;
	bh=DPQK7jJbge9Ks3zW2NwRo/uO5yMfC8kVDR4q2MaAGQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peQ01X6NCSnBM/iLdQhIyQjwbK+fBwL2E47EA9mpGOxZrXWD5+AcOHTZg54cE7itk
	 BRbJUkPGzledin8MibkKHQEct6FabO5nUh6pashzY/7cLREAArLONVy7fl4giGEVt0
	 3tMrUEt+XGn1gilRPZgjS9wrHStAJfCqXqKRzTmejjG3zcQhFjDjUP7BgLzzmoBxgm
	 krbDNRUz7NvRxCQnjFWY4NFzLdTXWUW2KsCUTWKGG7QZe/Wc7X7BUvgI6V2zwNdfl2
	 lThCKK4aMg4vQtGdRuyX1RD7eUBKH+c//JFK8TnmhBW7C2Yifwgnuyaw/wUIpc5C41
	 yd94z5avHdwLg==
Received: (nullmailer pid 286256 invoked by uid 1000);
	Fri, 15 Dec 2023 19:52:45 -0000
Date: Fri, 15 Dec 2023 13:52:45 -0600
From: Rob Herring <robh@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: stable@vger.kernel.org, agross@kernel.org, broonie@kernel.org, andersson@kernel.org, robh+dt@kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org, conor+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v1 1/2] regulator: qcom_smd: Add l2, l5 sub-node to
 mp5496 regulator
Message-ID: <170266996013.286103.17303148912355511017.robh@kernel.org>
References: <cover.1702618483.git.quic_varada@quicinc.com>
 <612e9d983333560f39672bf09c2d68b1d6ff91c0.1702618483.git.quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <612e9d983333560f39672bf09c2d68b1d6ff91c0.1702618483.git.quic_varada@quicinc.com>


On Fri, 15 Dec 2023 11:07:03 +0530, Varadarajan Narayanan wrote:
> Adding l2, l5 sub-node entry to mp5496 regulator node.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


