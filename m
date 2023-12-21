Return-Path: <linux-kernel+bounces-9063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E2781BFC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4081282FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4B276916;
	Thu, 21 Dec 2023 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQHlCCxK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA828768EF;
	Thu, 21 Dec 2023 20:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99591C433C8;
	Thu, 21 Dec 2023 20:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703191742;
	bh=776Bl4yQjHxeNqCrabr1mp5Wr+2TT5xJKRcbJImOcbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQHlCCxK9e4VGAeGf9Page52lFos2eoFpmVnXFJv2uYN3rpMLVYvnPce7tirl1DZl
	 IPsZJnskAw8V+ERcC1d+RlNyZW6FedQn3/s3tGI+5N+O3cI9BWrmVCjqBNvp4noJ1B
	 649BtkuzzgnrhaIgPBFgZ2pdfN2Kmp38TLj16KryS7l4deRoLaEnWRhzLNmou9Hzy/
	 rxmvtN5IynO43IT/1QbKp7BCHy4go+gntg+0G8M9vXYZ18h5GU4kU9egJml8ZnDCXq
	 S/maUCgVeKYLwcWbOFtOPjCZpBkiCwKgNHvZMwEgFkZIcMdiCaele2ETG/bkd5JFwO
	 5apGSkPFupP9g==
Received: (nullmailer pid 67984 invoked by uid 1000);
	Thu, 21 Dec 2023 20:49:00 -0000
Date: Thu, 21 Dec 2023 14:49:00 -0600
From: Rob Herring <robh@kernel.org>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: Raul Rangel <rrangel@chromium.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, Tzung-Bi Shih <tzungbi@kernel.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, LKML <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 19/22] of: irq: Remove extern from function
 declarations
Message-ID: <170319174018.67933.17367182938646030721.robh@kernel.org>
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.19.I319e781c11e6352eb5b6c408dc20bd54a720edbf@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220165423.v2.19.I319e781c11e6352eb5b6c408dc20bd54a720edbf@changeid>


On Wed, 20 Dec 2023 16:54:33 -0700, Mark Hasemeyer wrote:
> The extern keyword is implicit for function declarations.
> Remove it where possible and adjust the line wrapping accordingly.
> 
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> ---
> 
> Changes in v2:
> -New patch
> 
>  include/linux/of_irq.h | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


