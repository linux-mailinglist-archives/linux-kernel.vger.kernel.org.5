Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00427E8245
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344911AbjKJTKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbjKJTJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:09:57 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AD24EC3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=UkeffA2vSHpOXayjcOQRwDykg5JYTTVBikvJKRaYmgk=; b=f2ksT5QD9cT7H8uSap3qPHtuR3
        RG86H6Shv3V/1HqpllsDTpnrcpRiP04KKabC4c4hRR9cZqSsh39ebrJpw3MkG3DVEzDJ/8R03jslH
        OfKlvgRWq9zcqbfWK/q0W+XhWobJED6FUyNeY8YfHuTm3GtjnW/PvNAVcCG14F5BW1i4aXYu4EhVf
        F7LFAhCWtsZ5NgqNkcsLe8R4Ak9u9/TsWdQVqOx+LUKA0KF1QN27/dy6vrtyfu/sgGqdIO4ovgEjx
        aKr9sU5WOWrmSNl+pBEMzjnY2FXGPjH9PkZu2KJlKPm+ZnAmwfcg7HRiERJeyog2OOPaPFE/5wsXw
        yf+0dGdw==;
Received: from [2603:3004:644:9100::58b]
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r1WKy-00FmxH-2i;
        Fri, 10 Nov 2023 18:34:37 +0000
Message-ID: <0c264881-f54c-4db3-ae6d-34facc31c9e7@infradead.org>
Date:   Fri, 10 Nov 2023 10:34:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/chrome: sensorhub: Fix typos
To:     Kuan-Wei Chiu <visitorckw@gmail.com>, bleung@chromium.org,
        tzungbi@kernel.org
Cc:     groeck@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <ZU3GbHTA3x19h2Zi@google.com>
 <20231110165239.1559109-1-visitorckw@gmail.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231110165239.1559109-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/23 08:52, Kuan-Wei Chiu wrote:
> Replace 'preceeds' with 'precedes' in the comment.
> Replace 'porod' with 'period' in the comment.
> Replace 'noone' with 'no one' in the comment.
> Replace 'lantency' with 'latency' in the comment.
> Replace 'kifo' with 'kfifo' in the comment.
> Replace 'change' with 'chance' in the comment.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> v1 -> v2:
>  * Separate patch series into two patches.
> 
>  drivers/platform/chrome/cros_ec_sensorhub_ring.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

