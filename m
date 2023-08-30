Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE69978D23E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241791AbjH3C4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241790AbjH3Cz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:55:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 807C91BD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 19:55:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91A742F4;
        Tue, 29 Aug 2023 19:56:34 -0700 (PDT)
Received: from [10.163.58.191] (unknown [10.163.58.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF5CA3F740;
        Tue, 29 Aug 2023 19:55:47 -0700 (PDT)
Message-ID: <3622f8fe-00c4-298e-0b35-06bb61b92cde@arm.com>
Date:   Wed, 30 Aug 2023 08:25:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/mmap: Define DEFAULT_STACK_GUARD_GAP
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20230828035248.678960-1-anshuman.khandual@arm.com>
 <ZO3lQn8XZA+Q9/dF@casper.infradead.org>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZO3lQn8XZA+Q9/dF@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/23 18:02, Matthew Wilcox wrote:
> On Mon, Aug 28, 2023 at 09:22:48AM +0530, Anshuman Khandual wrote:
>> This just defines a macro constant i.e DEFAULT_STACK_GUARD_GAP representing
>> the default gap, guarding the stack mapping. This does not cause functional
>> changes.
> 
> But why have you done it at all?

Just as a normal cleanup which also improves readability.
