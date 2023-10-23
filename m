Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700C47D3797
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjJWNSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjJWNSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:18:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836FFAF;
        Mon, 23 Oct 2023 06:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1698067086; x=1698671886; i=j-p-t@gmx.net;
        bh=94IQzn5Tn+Z/xQWn2VBX1irEJtj0YzFaK/sAp4nGiSw=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:
         In-Reply-To;
        b=ppMmHtcGP2dOyafiEIQXCktraIaq8Qv5E4+rzYC4vys/Ax8Rx3V28mOpVelVDfJ4
         7JB0vBbIqby87QTCunE8LNbraRFMh5b27VeaJvTALqrCjzpzn4WWTn4t0i45g0urg
         8VcuouE4ckrwR1jsTk6cpGqAQREeVDSSvGYUhwAkH4UjVUhhrMZtdlbjZPVpxvGar
         PGkk7zpp4GT+FEsafjUrbZ9eCa04sfKk9bPULI1GYFvhmhQvVKrIH9kehLnnFux8h
         eQ2a9dSYXdTdiez+pAZk4smNcGxGiAwWwQlrDV1qqOfsETUDFqv30ZKWUWf5citzV
         YJCPdORNcjk39yHWhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.58] ([45.14.97.35]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2V4P-1rdmdt0JAt-013wKz; Mon, 23
 Oct 2023 15:18:06 +0200
Message-ID: <73357cb7-ba96-461b-a214-cd37b2223204@gmx.net>
Date:   Mon, 23 Oct 2023 15:18:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   JPT <j-p-t@gmx.net>
Subject: Re: si2157 not working at all?
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Media Subsystem <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Gon Solo <gonsolo@gmail.com>
References: <08125fef-3cb4-4f01-975c-d7c409153c4a@gmx.net>
 <ZTT0kZCijyLDN1LG@debian.me>
Content-Language: de-DE
In-Reply-To: <ZTT0kZCijyLDN1LG@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:laEO7C2Ci12egju8q+e1AAlTuibeG9Yh+jD7vCfimOUpbmj3dQy
 NC8GUecT+N629YlwZK1steKYArVHeneEIbXoUJ22mpjFuIlCYvQeziTDJpIuWPmpjYWJBld
 O/jFsTSKph7GpOkhqzqmoSuZ/AbG/j50LpK+Ro9he4uLj0e8doMMfzMnRhU8SsPkSJLhJGc
 TneE6fvLF61ISnWIzOlyg==
UI-OutboundReport: notjunk:1;M01:P0:wTtvp+o6wIs=;+f1z6jKZ7K4pxR79PT2lupH3JPr
 YSHoB+E9brRix146GzB5Pmid4xPlYrVMkKiIdpngnHqRzFcVAjXkYHH3nwgZGrd8G8xzKQ4Al
 1GURi2Tf7Qsw6vCzxj+d4uJfGyfX3F7xLDq2T0gauINocoeThNmCpvmKb7EXfdZbQe4XWvolb
 l/vNdmouu9dvfuA5lBeZaUsJ12MDQvms0Q7Bnk/7Ijr4eCDQ3aNOOgFL0jk1rYeNzEZA0ksjb
 qQ/ajHFKmICEm6X+6wz0H/c7m0gWIRZuDGIwrMPqpJVFk7FEkT9ysXhVNXNYCqdkSRFbxu73N
 VUZgldam+hnsA0CedfaDrAwPMBpum3ZELy9CoePHieGBDz6rsjIM2iL2aDLdkuTZJjJ6za/iz
 ViTs+kfGi/i4IirpoYJVmLBU12mYbS7vt0JVo6oz0A2xn6l1hlnqB2HHHK/yxKy+IkxhvQk50
 TLvs0A/MumC/hw63chUbRILzcQMa2rMasQnds0QS0ya/0N1oMMFggVbeMv8LyE36TNdffmMG8
 aqXW9t6/E6X+F8szhbMNGRh/1k7E2zd5FV1kMH8aa5LTNyloWdPcDs6khA3ulcANtJe4OS4BK
 UAwgfdaJBOndi6WtNrvImEQPplmEzeQQbakPpt6E1vQknWVBGyUCfG0G3iPmG3tXG56XNrDqK
 ECHXQnwx7e+LGYkhgEAcJRV3SlsFIzr9MPaMPXvc7yfVYTj8NvZ+6RvT2GaxNkuHkXXq5oYyp
 DBc1vJo8tPk9xZeP5XKAuQnpwGRsDHZXtkbiHufiH03I7sPdAan3VwGLlSdkWcWygtWVShOqo
 1dNuNUUQ09Rc8nO2elC94Ue7AseG3/xzRCtCXA3RhfwwjNsjqBvpmjHQIyXFO+076hdPobUu+
 gGrNzrKsw0mIRWLze4/V5nPUFpTWRFfTJYhpTHGYynQoSvu+E8bQsatBIjnz1ZUAGSMngSMFF
 oMA8nQ==
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 22.10.23 um 12:08 schrieb Bagas Sanjaya:
 > Can you check latest mainline (currently v6.6-rc6) instead?

sorry. My backup laptop broke down while trying, so I wont be able to
build and test a selfbuilt kernel any time soon.

I was able to make the device partly work on
LibreElec12@raspberry pi 3B+ kernel 6.1.58
dmesg see http://ix.io/4JKJ

But I wasn't able to tune into anything yet.
The Hardware ID is a dublette and pulled a wrong driver on LibreElec.
After blacklisting em28xx, the correct driver was loaded.

I still get the message regarding firmware not loaded because buggy.

> On Sun, Oct 22, 2023 at 09:57:07AM +0200, JPT wrote:
>> Hi,
>>
>> I've got a
>> 	TerraTec Cinergy TC2 Stick / Terratec Cinergy H6 rev. 2
>> DVB-T2/DVB-C USB stick using chips:
>> 	IT9306, Si2157, Si2168-B40

> Do you already have latest linux-firmware package?

 From what source? Ubuntu repo?

I manually fetched from openelec github:
d8da7ff67cd56cd8aa4e101aea45e052  dvb-demod-si2168-02.fw
c8e089c351e9834060e962356f8697b8  dvb-demod-si2168-b40-01.fw
d643a75d2ced161bc5fb635aec694d9f  dvb-demod-si2168-b40-01.fw.bak (bad?)
0c3f6bc5028bc37cfbf3a16d480bbaa5  dvb-usb-it9303-01.fw
9822ca23d24c46569ede9e07b1f13eee  dvb-usb-terratec-htc-stick-drxk.fw

thanks

Jan
