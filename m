Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93492782B98
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbjHUOWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjHUOW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:22:29 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C021DB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:22:05 -0700 (PDT)
Received: from [192.168.1.155] ([95.114.20.39]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M42fG-1qY5mw3T6m-0002BN; Mon, 21 Aug 2023 16:21:50 +0200
Message-ID: <46e286cb-ca1a-4b5a-153f-0e0cade22bb9@metux.net>
Date:   Mon, 21 Aug 2023 16:21:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: using gpu's to accelerate the linux kernel
Content-Language: tl
To:     Raj J Putari <jmaharaj2013@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <CADXzsigVPkgkx4vmaKnhGuMdjt_3w0Fo3eFqDNSwyoH9JCrRQw@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     dri-devel@lists.freedesktop.org
In-Reply-To: <CADXzsigVPkgkx4vmaKnhGuMdjt_3w0Fo3eFqDNSwyoH9JCrRQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Dy7XZaNpxg/TFmWO/wN8tgcOojM+zEN9fu3AsMkrZiRRrNMVlzB
 Sd0q0AS0MiD/UO9QATzPtGNKdDZ7UU99W2zVaVWaUM4gNj2tg0tvrnVYqqo2lmXCRrpUdEf
 PgoNriPvgnGGbyZ3SFNA3ZL2LwhTeDsyxefhLtZkYat03flqsav24Ta8Q4FFi6tsZJwGztg
 6rMdeKWHK5PfIJGAyAaww==
UI-OutboundReport: notjunk:1;M01:P0:0IMJ2TltKo4=;FRMGWKs7008PC9jzLH+IhO7Kqdw
 rHa+ciDDRvHEGVC1rAe7g880wg63H5kb88l44haUMcn8Tq6O+eCUGPlHnUXX+yNlhzHs1kbqd
 FIRSaw+t4f3ipluWqk6Ue3N424r0cUnTOO6HSAiE/4Mc1gK/HNP5nBsCdzCJx9f91o4aO9LeJ
 pn+StSPNL9G7qXUBabIWxE+xoMt2+yfwua3QmIojIYCuUTB4nusQE2Zq1PebXFjMUW67AHZOp
 /dX9vQLP5o0CKPHoRfxcOOnCPDi3h2eMw0UZHUAafDTUUXPR32fS87kINRVsEWr77w8VqZ8Bb
 TWsrui8ejgpto02Ho6EuZ6s/QgHReXwFBMOixPfR9qhYrG9DmA1GWapl0DRGvd0M78e/SPBNO
 q/r7sfREkKG6wNvlwZdcRq5SC8GB4Z8aTCatUAVdYba4DWUhL6nnV5sSLThxO6dX+6llCBkRQ
 1NzwjY9l7xHOBBjTlf1iJOZBWVLsjWuwfjcso55EQe+ECajWDIDsBKBokKr/Co7z1H//gzqoU
 pY/EnmBsgKMy3GQh7ej95ZLUAEiQei+uBbRWEi4/m8nOdb3+czVQ/06hMq6Y8YLZ0TL6ke3Ub
 e10zJIEy9/5dNTOJdRT2OsCzzUKfg/N2l4s8bk7tLNYVbUeHGukG2+pKnqaCw40wsR8fd2bk3
 MWfl1ylhbYo97t4NaOdQSsiQzfV3zcdh4nq7L4mjbMfwYBvvcIbKkVotLVX+9fhRZHGn3pcVD
 HIUTw22AQFzA+Kr8TexeqGrS1JB+yieDJcsa59rxvDzsyZQkkPj11JioIvLxzO9yLKEMY5AZl
 zq4GkonQPuQ1GoMRZ8wDDKD+wiAJsvfXjKJ7T3egejf7SiTdrLvvQr4Cg3rAwaI0OVsgGqWBU
 wZbXB6w8uwSEW5A==
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.23 12:51, Raj J Putari wrote:

> id write it but im an amatuer and i dont have time to read the kernel
> source and experiment, we're talking about nvidia and amd video cards
> assisting in processing heavy data.

obviously not w/ NVidia (except for some old, already reverse-engineered
gpus), since Nvidia is doing all they can hiding the necessary specs
to write drivers from us.

Forget about Nvidia. Never ever waste a single penny on that.

> lets say youre compiling a kernel, you can write optimizations into
> the kernel through a cuda module and offload cpu data directly to the
> gpu using opencl or cuda or what amd supplies,

cuda, opencl, etc, are *userland* *library* APIs. They don't work inside
the kernel. One had to write something similar *inside* the kernel
(which is working very differently from userland). Also consider that
the most complex stuff (eg. creating command streams) is done in
userland (eg. mesa's pipe drivers, ...), the kernel is just responsible
for some more lowlevel things like buffer management, modesetting, etc.


If you wanna go that route, you'd have to create something like Mesa's
Gallium inside the kernel. Besides that this is a pretty huge task
(and you'd have to reimplement lots of drivers), you'd also have to
find a way to get a good performance when calling from userland (note
that syscalls, even ioctls, etc, are much more expensive than just
plain library function calls inside the same process). Probably comes
down to using some bytecode (tgsi ?) and loading it somewhat similar
to bpf.


Assuming that's really up and running one day, it indeed could solve
other problems, eg. clear separation between containers and hosts
(for now, containers still needs the userland parts of gpu drivers
for the corresponding host hardware).

But be warned: this is a huge endavour, *a lot* work to do and hard
to get it right.


OTOH, I'm yet sceptical whether there's much practical use cases for
using GPUs by the kernel *itself*. What exactly do you have in mind
here ?


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
