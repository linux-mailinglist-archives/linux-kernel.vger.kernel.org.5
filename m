Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58B575DE23
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 21:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjGVTAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVTAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 15:00:31 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326509F;
        Sat, 22 Jul 2023 12:00:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E01232AE;
        Sat, 22 Jul 2023 19:00:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E01232AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690052429; bh=Ly/oUr3B7aUKm5QXEvEFBPrkFUbj60dJNU9A8yXKcpc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cpttkpvFAP1LI1OarUiqvJn7vUHGV5XjO+C5tEarMf0/gzt8fPdaX1MeoXQEMhHbn
         OsuqdGvRI2mmcpreD6I5ZzfBjUORdgugvRPmcdHv8QTehKOVoQcDQlP+LXA2N4MJoL
         Ni3N3991n6QmWvAvX8W2V9eOErYd/rqfe1ZirtaNxaqQrrHaRk/30AJlbVe0aQJ/Zb
         fr45+960c8/ffTPOIrkQyBsn2AK2JhAwsowHNQtkpjGcnR0Sp6dMvrTRyXoJEpRzyp
         kkbdCVYz+0rsr4eUx0eYhU6gLLqrHPkmxzqTInEV/imR23iqHdLPABdccVx2z58SP3
         N7HPUxXpoFqkQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v4 1/3] Documentation: arm: Add bootargs to the table of
 added DT parameters
In-Reply-To: <d8db4fc3-12b4-43f1-ea94-5dc53ce2d55f@ghiti.fr>
References: <20230626143626.106584-1-alexghiti@rivosinc.com>
 <87v8edas8d.fsf@meer.lwn.net>
 <d8db4fc3-12b4-43f1-ea94-5dc53ce2d55f@ghiti.fr>
Date:   Sat, 22 Jul 2023 13:00:28 -0600
Message-ID: <871qgzbwkz.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Ghiti <alex@ghiti.fr> writes:

>> In the former case, they don't apply to docs-next, so could I get a
>> respin please?
>
> Yes sure, I'll do that now. BTW=C2=A0 all the arch documentation was move=
d in=20
> Documentation/arch/, but not the riscv, are you working on this or=20
> should we?

I'll get there - unless somebody beats me to it :)

Thanks,

jon
