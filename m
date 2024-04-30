Return-Path: <linux-kernel+bounces-163348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3481C8B69B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660661C21D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F00A179B2;
	Tue, 30 Apr 2024 05:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7hTHO+n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FD4175AE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714453746; cv=none; b=UYo18hILfx206AZpv37l6IyN6N99RTmBo27rWTS4kxsHTXqFtC1CIpBbHMW88GauB359YkKr7dTZbImd+TIgpLzIiiqE9mXXPAfB2SAoTo/m4mnzm4CCC3spngAEcSbr05/hBi3RVscW6px8i1hHjghlRii9I+ys6WGVz5vbZUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714453746; c=relaxed/simple;
	bh=J+SzwUyls9SaMVVFBi7PpXJ+4++slrdMAi6eCnVxZ30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=adMqiphV4JxpSjp41ad1ebKZGgsk/Kg8c1pYjdFXPWcKpeY94gWVoORGVvmo1CkK7earXz9AEMnYIIuOs5qldBiZf+nxcfVVRTFrdnRQKS/fyQc5V8HLL9032EjXpCFk+TlSZZixfZ3MyUjFdiKewBhGD9rs8XpQVWadfDSXkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7hTHO+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305F9C2BBFC;
	Tue, 30 Apr 2024 05:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714453746;
	bh=J+SzwUyls9SaMVVFBi7PpXJ+4++slrdMAi6eCnVxZ30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=H7hTHO+nqAqz262HEwuQx9nek6KdJSHo/iMy65xKf1Q/M66hF7o7LY6ULlgljSObN
	 CHSLsbGq9JWM+ol0UtxI1xVOmRD9zbWW4Pc2vDqDIprQlDu/EQU2dXR/BdZ93IZfeJ
	 p7CZJEsT6PEL4VEat+QY1sPCRGhDnwumcFUTdu6CHF7l4D9YaWdrEBUfgyr7U/QaHu
	 2v+14XmeD5GmZcUlVYSsRuauJmiBeSj5Gx2Xf1WA2xTF5HicXEKZkicogmBTj0lu3m
	 agFpz/00UNSGr7TFj0Z/Bno9QCr174whBE07ZYyf/7bGjn+wgEFErdOuEdcm/6KVmN
	 9YRGlkiCtKE8Q==
X-Mailer: emacs 29.3 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, will@kernel.org
Subject: Re: [PATCH] MAINTAINERS: MMU GATHER: Update Aneesh's address
In-Reply-To: <20240430044327.49363-1-mpe@ellerman.id.au>
References: <20240430044327.49363-1-mpe@ellerman.id.au>
Date: Tue, 30 Apr 2024 10:38:58 +0530
Message-ID: <yq5av83z4etx.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Ellerman <mpe@ellerman.id.au> writes:

> Aneesh's IBM address no longer works, switch to his preferred kernel.org
> address.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
 
Acked-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
 
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93af33ee8541..f096c9fff5b3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14898,7 +14898,7 @@ F:	drivers/phy/marvell/phy-pxa-usb.c
>  
>  MMU GATHER AND TLB INVALIDATION
>  M:	Will Deacon <will@kernel.org>
> -M:	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> +M:	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	Nick Piggin <npiggin@gmail.com>
>  M:	Peter Zijlstra <peterz@infradead.org>
> -- 
> 2.44.0

