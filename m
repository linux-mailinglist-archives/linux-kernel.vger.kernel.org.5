Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627D77DC5A2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjJaFEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJaFEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:04:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95A1C9;
        Mon, 30 Oct 2023 22:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=+9mvGdCWRziwRBlUvLpIBIs9buwYvmhv/N6u3r2ZS0Y=; b=s5Yr/xdSP8qucbLVnS0k+DtJhm
        cwiBGl5YRIx3fIobgvRJFVv0uUp1Zz127Dzencsn/5huxdopm83kJWQnprMX3SPcrwo7oUJRFZYHz
        SJMhQjgzYhyNKXHYB4dGZ8AuD66Cr/loJ2lG9aeSe5lWxadEl0sFwChzyhLDMusAQ+cQ038FgL6ZN
        Ld5VFTlaJNY20thm6hn5A43aUlsgyDEPOf/Ah3WStoqMY6EsC+GAjI0n7ldc/NLFM+5fMkUfi/2s3
        i7v4KhTSbCbwz1kw+t154M72JgxWE/Ixc3DSFLagVlL/u6gDztI5iRfDVXESGtJPvB+7FzNSL211h
        +eIRnVVw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxgvb-004YAm-0e;
        Tue, 31 Oct 2023 05:04:35 +0000
Message-ID: <dc312544-6070-4299-b9ee-903b34d7cf21@infradead.org>
Date:   Mon, 30 Oct 2023 22:04:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Oct 30 [drivers/cxl/core/cxl_core.ko]
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20231030163344.5a39a625@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231030163344.5a39a625@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/23 22:33, Stephen Rothwell wrote:
> Hi all,
> 
> Please do not add any material not destined to be merged before v6.7-rc1
> into your linux-next included branches until after v6.7-rc1 has been
> released.
> 
> Changes since 20231027:
> 

when CONFIG_ACPI is not set (on various ARCH):

ERROR: modpost: "pci_print_aer" [drivers/cxl/core/cxl_core.ko] undefined!


Already fixed?

thanks.
-- 
~Randy
