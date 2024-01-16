Return-Path: <linux-kernel+bounces-27537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3B182F1C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B801F23AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8ED1C687;
	Tue, 16 Jan 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJz7ajbP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691391C298;
	Tue, 16 Jan 2024 15:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03ACC433F1;
	Tue, 16 Jan 2024 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705420123;
	bh=O49fZM3TYYx0viOOAtw2wmoD1vZvsLcuxqV/YnXt0cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJz7ajbP/DKiVzOpv+NOMxKUFUSUsLZael48iQS4cgllPs8B3r+pi2OuXDUi3dDif
	 LYZwfti/fuGOFcVoCfCruxkkG2bEeFqiB3jOM0MYP/FoX3e7qW7kiiJb0JbnlNilmz
	 fW8mXF4afycwnIT8SYWc2in9ti0jc7JynZeSFghMpmsr0yYSbBK+Ahi5cyensmKzd5
	 vQ2FtvmHh/Zpk8vnSWL2D67J4PTi4Q8CDcocwcP4rY8kLyj9M0qmjnUKzuA61kHPUh
	 VZMey4hYLx1ODPcjG1gGaENOO6t4C9BMtZ3iGSgDR3SPJFZAYM9dfuq8QNWMtXu5c3
	 OmJxykFL5UsfA==
Date: Tue, 16 Jan 2024 09:48:40 -0600
From: Rob Herring <robh@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-clk@vger.kernel.org, andre.draszik@linaro.org,
	linux-samsung-soc@vger.kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com,
	devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org, cw00.choi@samsung.com,
	peter.griffin@linaro.org, robh+dt@kernel.org, tomasz.figa@gmail.com,
	conor+dt@kernel.org, semen.protsenko@linaro.org,
	linux-arm-kernel@lists.infradead.org, willmcvicker@google.com,
	kernel-team@android.com
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: gs101: rename cmu_misc
 clock-names
Message-ID: <170542011998.4183893.12913158398991338657.robh@kernel.org>
References: <20240109114908.3623645-1-tudor.ambarus@linaro.org>
 <20240109114908.3623645-2-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109114908.3623645-2-tudor.ambarus@linaro.org>


On Tue, 09 Jan 2024 11:49:06 +0000, Tudor Ambarus wrote:
> 'bus' and 'ip' are sufficient because naming is local to the module.
> As the bindings have not made a release yet, rename the cmu_misc
> clock-names.
> 
> Fixes: 0a910f160638 ("dt-bindings: clock: Add Google gs101 clock management unit bindings")
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  .../devicetree/bindings/clock/google,gs101-clock.yaml         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


