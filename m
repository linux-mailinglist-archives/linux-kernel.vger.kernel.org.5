Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C1F75DBC4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 12:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGVKuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 06:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGVKuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 06:50:05 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE438E64;
        Sat, 22 Jul 2023 03:50:02 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D08EDC0003;
        Sat, 22 Jul 2023 10:49:56 +0000 (UTC)
Message-ID: <d8db4fc3-12b4-43f1-ea94-5dc53ce2d55f@ghiti.fr>
Date:   Sat, 22 Jul 2023 12:49:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/3] Documentation: arm: Add bootargs to the table of
 added DT parameters
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>
References: <20230626143626.106584-1-alexghiti@rivosinc.com>
 <87v8edas8d.fsf@meer.lwn.net>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <87v8edas8d.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/07/2023 23:07, Jonathan Corbet wrote:
> Alexandre Ghiti <alexghiti@rivosinc.com> writes:
>
>> The bootargs node is also added by the EFI stub in the function
>> update_fdt(), so add it to the table.
>>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> Reviewed-by: Atish Patra <atishp@rivosinc.com>
>> Reviewed-by: Song Shuai <songshuaishuai@tinylab.org>
>> ---
>>   Documentation/arm/uefi.rst | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
> So I'm not sure if I'm supposed to be applying these patches, or whether
> they will go through the arch trees?
>
> In the former case, they don't apply to docs-next, so could I get a
> respin please?


Yes sure, I'll do that now. BTW  all the arch documentation was moved in 
Documentation/arch/, but not the riscv, are you working on this or 
should we?

Thanks,

Alex


>
> Thanks,
>
> jon
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
