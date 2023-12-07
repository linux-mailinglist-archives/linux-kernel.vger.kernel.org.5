Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294AF808E66
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441947AbjLGQ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjLGQ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:56:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E589170E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=lPh8LMdFy5YnUc1DS1fRee/YgkA63td0Odm8EIiRxZo=; b=4ZQWyiBxBZmb+0TW0srqcJOAPc
        RY+5C5DCQfFRe6ZGbAeMGL6WXUi6oTrxrPy0OIRHkDX/wcII8ahej4KwA6K3V0T08B3nGOfnF4pMU
        zIQdXT7H3SdOuGX0Nj3pHqZlm2BfYzTRqhJ7kRLvRpF6EFl2XjJsbaNuyJxj3XAvKHD0dhOna06SQ
        96pFdCxpQQh2CVZ2Rsi+ZkaWVNCPsm/pqqRhvgbRzzyylgoUQDa/0WMpKKQTHPl0Hj+3oZJZvvffG
        l30wql0Hy61/t2YC5bFsvcKXCZOhplzM4qO75gNkvRsq1jm1EWg5Yzx+qFV9U8wm4HQd+N6d2LsS+
        XANPw0Ww==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rBHg6-00DSbw-18;
        Thu, 07 Dec 2023 16:56:46 +0000
Message-ID: <11399bd2-f49d-4708-ad62-bbaba424c4f8@infradead.org>
Date:   Thu, 7 Dec 2023 08:56:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/xenbus: client: fix kernel-doc comments
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
References: <20231206181724.27767-1-rdunlap@infradead.org>
 <c4fb61d7-d65e-4f6d-bb3f-cc961a70a757@suse.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c4fb61d7-d65e-4f6d-bb3f-cc961a70a757@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/23 01:27, Juergen Gross wrote:
> On 06.12.23 19:17, Randy Dunlap wrote:
>> Correct function kernel-doc notation to prevent warnings from
>> scripts/kernel-doc.
>>

>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>> Cc: xen-devel@lists.xenproject.org
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>
> 
> with one nit below (can be fixed while committing) ...

Ah yes, thanks.

-- 
~Randy
