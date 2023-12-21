Return-Path: <linux-kernel+bounces-9184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3854D81C209
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA203284EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA0879496;
	Thu, 21 Dec 2023 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lLtS1+Ui"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0952B78E92;
	Thu, 21 Dec 2023 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=XMT4r+72XxvS/xBUd8oRTVMPCIfc6GAAQaHu5rj89Gw=; b=lLtS1+Uiaxpgi56fQlx/fgWqBd
	mOchIHIxLUvD4M1tn64Bar8uDQO57us/W9YF9twMImwvFP068qCeK21ybWKNPs7bbOQYWjt01d//i
	OX+W9EdhPh6f+8/xDUjkN6w9+Df05MZ2HMpxIrKZS7lGrfckCuuRStM3E83719ou1OPE8d3WoJYZ/
	o1ThmsOTaK0USmlg12iwrCMaxxtLtxoL7k/yf+1PD0haXHyJLn3XPWhN/5JxIEGlM0MKwb9aSsCXI
	f+2VIhQQ/gKFOkKfjKKFG6zciZA/NkADBqYTOewtX2S7AT8kijdn2sY7f31JHkfhKXtO/paabGWdI
	NYw88h7g==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGScs-004RxN-26;
	Thu, 21 Dec 2023 23:38:50 +0000
Message-ID: <6ec27515-d2c1-48f1-8935-55f0ae48e72b@infradead.org>
Date: Thu, 21 Dec 2023 15:38:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: clarify intent of fan min/max
Content-Language: en-US
To: Ivor Wanders <ivor@iwanders.net>
Cc: corbet@lwn.net, jdelvare@suse.com, linux-doc@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, luzmaximilian@gmail.com
References: <40285311-8adc-4ca9-86ce-27c8b723a102@infradead.org>
 <20231221233133.14978-1-ivor@iwanders.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231221233133.14978-1-ivor@iwanders.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/21/23 15:31, Ivor Wanders wrote:
> This adds a link to the hwmon sysfs attributes in the hwmon patch
> submission bullet points. It also adds an explanation denoting the
> intent of the fan min and max attributes.
> 
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>

LGTM. Thanks.
(other than telling us what changed from v1 to v2)

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/hwmon/submitting-patches.rst |  4 +++-
>  Documentation/hwmon/sysfs-interface.rst    | 12 +++++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 


-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

