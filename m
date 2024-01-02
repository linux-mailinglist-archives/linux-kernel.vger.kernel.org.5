Return-Path: <linux-kernel+bounces-14607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E510821F8D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73ED283D92
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D14614F8E;
	Tue,  2 Jan 2024 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCosgBbj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402D14F69;
	Tue,  2 Jan 2024 16:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46947C433C7;
	Tue,  2 Jan 2024 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704213056;
	bh=EknTmyeauM3nCVXkhmleZP6wGWhZAuQEfEGgcAs31ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCosgBbjLfPRoju/l5ZL0oUqcOjjztKaa40sU+kDBYcf62AxH171fkAicIW7I5Tq1
	 61T0gE5S/AJyAHB5Ie/cKwXtmrMYGwIegs7js95mdY9USU4aMaDy1tGxDtHwDxDr6W
	 UoqqqRGy5dKCsBaBGlBavC0d2B9z//HcKO3HMj7Q+c/Hw7L9Roub0mFjMB2uklJCmi
	 yb6WJG2RElzwSyhWYv1AtVotXhkhb74HCD3hE8A5aLyLKEQ/4GmX3zTLeR4TG0bjfG
	 2IwhRUN9t4XpWU88B/3KScVOUahBYcLhjDIDE/vvUT4g/mIoxQVlkw7cFM0B2N/AHO
	 0MPvXy9ro3lIA==
Received: (nullmailer pid 2968777 invoked by uid 1000);
	Tue, 02 Jan 2024 16:30:38 -0000
Date: Tue, 2 Jan 2024 09:30:38 -0700
From: Rob Herring <robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-pxa: Fix 'regs' typo
Message-ID: <170421203410.2946186.5030215776329721242.robh@kernel.org>
References: <20231213224219.2191721-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213224219.2191721-1-robh@kernel.org>


On Wed, 13 Dec 2023 16:42:19 -0600, Rob Herring wrote:
> The correct property name is 'reg' not 'regs'.
> 
> Fixes: ae5c0585dfc2 ("dt-bindings: mmc: Convert sdhci-pxa to json-schema")
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!


