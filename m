Return-Path: <linux-kernel+bounces-14582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFE9821F23
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85889B22095
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B58C14F6B;
	Tue,  2 Jan 2024 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q++PqW+D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CAE14F60;
	Tue,  2 Jan 2024 16:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F99C433C8;
	Tue,  2 Jan 2024 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704211362;
	bh=1WCpt4WMSN+7nb/VCtM29y9fDFeJOuj/TwxVBcmMSeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q++PqW+DLdK8rkggKBBNJJxu56dzpDJ6vhoL7bAOt9uQnzVby6DreF6yfT7hKrlKm
	 4yvY3ZcwpUkzoK/7rcsT6VyuYJiITABJQlZj0eKT2ADhgFzfZ3onC1BThNRiFX6i04
	 zE/rfa5kboGt3l/tzAT6IdQoekAPI23ZvtSUlAWCI2vGfqMOa+SSTvy+njqhKH8ZlR
	 4oyxN3iUdVZ+eInmBND2fPMiyZwD8SLbfcgd9FlNYsXfgS+B+22yKP60gowx4uwJMK
	 BfMOnK2i4mCmKxNIvvBd0iU0Nukit1ZQfkDfwrHCONgqAPaY1o+vwXE2KPM3fSJ+iz
	 8O7HYxZ4fjBhA==
Received: (nullmailer pid 2928996 invoked by uid 1000);
	Tue, 02 Jan 2024 16:02:40 -0000
Date: Tue, 2 Jan 2024 09:02:40 -0700
From: Rob Herring <robh@kernel.org>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Raul Rangel <rrangel@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 20/24] of: irq: Remove extern from function
 declarations
Message-ID: <170421133956.2927980.11503215748681788966.robh@kernel.org>
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.20.I319e781c11e6352eb5b6c408dc20bd54a720edbf@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226122113.v3.20.I319e781c11e6352eb5b6c408dc20bd54a720edbf@changeid>


On Tue, 26 Dec 2023 12:21:24 -0700, Mark Hasemeyer wrote:
> The extern keyword is implicit for function declarations.
> Remove it where possible and adjust the line wrapping accordingly.
> 
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> -New patch
> 
>  include/linux/of_irq.h | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Rob Herring <robh@kernel.org>




