Return-Path: <linux-kernel+bounces-5528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A4E818BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EA0EB247C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFE21D138;
	Tue, 19 Dec 2023 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwlymSRp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC731D12E;
	Tue, 19 Dec 2023 15:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BFCC433C7;
	Tue, 19 Dec 2023 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703001548;
	bh=zQf0OGa0U7Bj4Rh9Xz7fetcGG8tDabxATlJL+Os0S9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwlymSRplAT28wj0wzLOZOTkJEwrc3gCeQ3RLKJX35NeTQJMIif1xspit13ZdLfQv
	 3OOs2vIYaT/npyJsIcyHen87CBilRPIP/ANqU1N/BPnZdDQHjD9AaFGG29XuZeveIX
	 JWEgj20j6dUymOhhkAKulRz8uneK7/dsyGEhSr3tsdiR0H4I+iliOprDy9U28nJP3b
	 U0iyIiqtl54ypRghZghAGS0sgru6PZKBzMLX88wkjuEozpderI0R5a7DJtyRHjhGNe
	 1zFt9XZ0bHQXorxogDZ9OUngHQZoxyUrcsM6EpQbGx2bw2HAZvKZzDbctOT28JsNLz
	 49ErdsfZ6npZQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rFcUs-0008Jf-1c;
	Tue, 19 Dec 2023 16:59:06 +0100
Date: Tue, 19 Dec 2023 16:59:06 +0100
From: Johan Hovold <johan@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dt-bindings: thermal: qcom-spmi-adc-tm5/hc: fix up
 examples
Message-ID: <ZYG9yqyoul-gaEGs@hovoldconsulting.com>
References: <20231130174114.13122-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130174114.13122-1-johan+linaro@kernel.org>

Hi Daniel and Rafael,

On Thu, Nov 30, 2023 at 06:41:12PM +0100, Johan Hovold wrote:
> When reviewing the various SPMI PMIC bindings, I noticed that several
> examples were incorrect and misleading and could also use some cleanup.
> 
> This series addresses the thermal ones.

> Johan Hovold (2):
>   dt-bindings: thermal: qcom-spmi-adc-tm5/hc: fix example node names
>   dt-bindings: thermal: qcom-spmi-adc-tm5/hc: clean up examples

Can we get these merged for 6.8?

Johan

