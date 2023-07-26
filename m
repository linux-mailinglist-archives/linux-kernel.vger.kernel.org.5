Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BFC764277
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 01:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGZXRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 19:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjGZXRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 19:17:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ACD110;
        Wed, 26 Jul 2023 16:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=+BxaI4cEGjRv9nbnzBpH4y1WwQ27txPUEG6lpfLP6uQ=; b=kuOCL1+Xg+mYo1HmJMJQ04dGiH
        eg4PjG9smUnMOFUfd/XYypNjLnYVSZkgZbpkIMQ+0mlxQBEFtI0On4cdKZlki2ckggsWp23l8ir7M
        wmiLtTbutKdTJAmVvmxxZFej6+yEqGkrgSuQgSaXso7fS5clPuzzIEtKjgiVaXRhXUgXiQdHGC0oP
        LHTNj2sJo+voKekR3hTIwfuhLh3SBrqANM4pcBWX9j5A8KECa5A/Vy/3TWP+Y1QBF/bRZZltWfCB+
        h9VXbMfin2OS6XrRi69NIaIGUq3pSIu3jDOh7zpy9EpdDrr5/kJAmb6Qm6HwHXFZncLMMwLRVILXa
        Pp7MY9+Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOnlH-00Bhsr-0Z;
        Wed, 26 Jul 2023 23:17:43 +0000
Message-ID: <f28bfb83-49c6-53b1-71db-aba815505af4@infradead.org>
Date:   Wed, 26 Jul 2023 16:17:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Request for linux-kselftest nolibc branch Inclusion in linux-next
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, linux-next@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, Willy Tarreau <w@1wt.eu>,
        thomas@t-8ch.de, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <4a007283-be03-907a-094f-6651a44e631f@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4a007283-be03-907a-094f-6651a44e631f@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/23 15:22, Shuah Khan wrote:
> Hi Stephen,
> 
> Please include the following linux-kselftest nolibc branch for linux-next
> coverage. This will be based on Linus's tree.
> 
> I will be using this branch to send nolibc pull requests to Linus.
> 
> URL for the branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=nolibc
> 
> Primary Contacts:
> Shuah Khan - shuah@kernel.org or Shuah Khan <skhan@linuxfoundation.org>
> 
> Please cc:
> Willy Tarreau <w@1wt.eu>
> Thomas Weißschuh <thomas@t-8ch.de>
> Paul E. McKenney <paulmck@kernel.org>

Should the MAINTAINERS file entry for NOLIBC be updated?
(I think so.)

thanks.
-- 
~Randy
