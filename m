Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A64A78ECA7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243018AbjHaL76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjHaL75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:59:57 -0400
Received: from ustc.edu.cn (email.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1483C5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:Message-Id:To:Cc:
        Subject:From:In-Reply-To:References:Mime-Version:Content-Type:
        Content-Transfer-Encoding; bh=XB0WHbbAg+OjhsS9TDKeQE27W5Q+vohE/H
        d1XoRzsrg=; b=sHDX34ydiuCZ22PHqTOJqpm7393caR7Ff2oFbvr2EF6Qw1DOmc
        G8yesL1vNy6MsDxY0BV+94p888R3zR1+BmWA86Egkzv5CWtAnG9L8LT4afB1pRHp
        2CJzJUCg5sJZ0YqruKqkt1gi8RD0CRzFfRaKvCNV2eJM9/R2SPC7E4kKA=
Received: from localhost (unknown [101.88.124.132])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCHjKyngPBkUCqlAQ--.2708S2;
        Thu, 31 Aug 2023 19:59:39 +0800 (CST)
Date:   Thu, 31 Aug 2023 11:59:37 +0000 (UTC)
Message-Id: <20230831.115937.924195103727242070.hchunhui@mail.ustc.edu.cn>
To:     robin.murphy@arm.com
Cc:     hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma/pool: trivial: add semicolon after label
 attributes
From:   Chunhui He <hchunhui@mail.ustc.edu.cn>
In-Reply-To: <d5ef27f1-9e6d-5e3c-b7ea-4b0abca623ed@arm.com>
References: <6f936d6e-9f27-ba72-68de-0ed27c0dbbe1@arm.com>
        <20230829151216.GA4211@lst.de>
        <d5ef27f1-9e6d-5e3c-b7ea-4b0abca623ed@arm.com>
X-Mailer: Mew version 6.8 on Emacs 28.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygCHjKyngPBkUCqlAQ--.2708S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryfWF47CFykGw18uFWfKrg_yoW8tFy3pF
        y8JF1DK3yDJFn3Gr9Fyrs29F1Yvw4aq3y5GFnxJr1SyanrXw1SvryjqFZ09FZxKr4kGwsa
        qrWjqa9rXw45ua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyab7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I
        3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
        WUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
        k0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
        Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xHUDUUUUU==
X-CM-SenderInfo: pkfk30xkxlqzxdloh3xvwfhvlgxou0/
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Aug 2023 16:28:05 +0100, Robin Murphy <robin.murphy@arm.com> wrote:
> On 29/08/2023 4:12 pm, Christoph Hellwig wrote:
>> On Tue, Aug 29, 2023 at 03:22:22PM +0100, Robin Murphy wrote:
>>> AFAICS, what that clearly says is that *C++* label attributes can be
>>> ambiguous. This is not C++ code. Even in C11, declarations still
>>> cannot be
>>> labelled, so it should still be the case that, per the same GCC
>>> documentation, "the ambiguity does not arise". And even if the
>>> language did
>>> allow it, an inline declaration at that point at the end of a function
>>> would be downright weird and against the kernel coding style anyway.
>>>
>>> So, I don't really see what's "better" about cluttering up C code with
>>> unnecessary C++isms; it's just weird noise to me. The only thing I
>>> think it
>>> *does* achieve is introduce the chance that the static checker brigade
>>> eventually identifies a redundant semicolon and we get more patches to
>>> remove it again.

Inline declaration is a GNU C extension, so the ambiguity may arise.
Adding ';' makes the compiler easier to parse correctly, so I say
"better". The commit 13a453c241b78934a945b1af572d0533612c9bd1
(sched/fair: Add ';' after label attributes) also says the same.

>> Agreed.  Even more importantly that attribute looks rather
>> questionable
>> to start with as it can be dropped by just moving the #endif a little:
>> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
>> index 1acec2e228273f..da03c4a57cebe3 100644
>> --- a/kernel/dma/pool.c
>> +++ b/kernel/dma/pool.c
>> @@ -135,8 +135,8 @@ static int atomic_pool_expand(struct gen_pool
>> *pool, size_t pool_size,
>>   remove_mapping:
>>   #ifdef CONFIG_DMA_DIRECT_REMAP
>>   	dma_common_free_remap(addr, pool_size);
>> +free_page:
>>   #endif
>> -free_page: __maybe_unused
>>   	__free_pages(page, order);
>>   out:
>>   	return ret;
> 
> Oh, indeed - I hadn't really looked at the context itself. My
> non-exhaustive grep skills show a couple of hundred instances of
> label-above-#endif vs. three (!) instances of __maybe_unused, so ack
> to making that cleanup to just remove the question entirely.
> 
> Cheers,
> Robin.

I agree label-above-#endif remove the question entirely.

Cheers,
Chunhui.

