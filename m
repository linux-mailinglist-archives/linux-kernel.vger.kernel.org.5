Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA777F6AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjKXC3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKXC3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:29:11 -0500
Received: from mail.oetec.com (mail.oetec.com [108.160.241.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E101BE;
        Thu, 23 Nov 2023 18:29:13 -0800 (PST)
Received: from [172.16.35.9] (cpe8c6a8d4d360a-cm8c6a8d4d3608.cpe.net.cable.rogers.com [99.253.151.152])
        (authenticated bits=0)
        by mail.oetec.com (8.17.1/8.16.1) with ESMTPSA id 3AO2SFvu006653
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Thu, 23 Nov 2023 21:28:19 -0500 (EST)
        (envelope-from dclarke@blastwave.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=blastwave.org;
        s=default; t=1700792902;
        bh=JRz+QuHSFTwfDW25GUsrNtjXacUb05swqDkWCTxkAA8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BNW7zGXLRrdeN3QwI6yFl0ZSPczO6S18wtTyd1fajx00RENDtEwrEgEbgpDIHDQk1
         gxwSbQM/SKdn32KslD73V1g+YF6kTBLVD9854eX7o14nObG8Nf/uy38zwgeZHeu8zc
         dgGIAIeXTAfcpjP7tyr1AVl0I3EECTg3ctdx5pQAF0O4ExMcKp4AHFJ6d6qXgFJvIv
         MUIqsz5uRQPsLZSAd7AXxVWGQaJ96hjrEl7fz5SrP74D579eY3003Hb5+SYTsMDlOF
         8BSHROPpIR53R4+AqdcqxPyTlqP6nGzUMDepszvWAIZTh1BmMPOucuGdWQ9x/8i0F6
         9OciftRgCyLzg==
Message-ID: <267f0b5a-5da4-4145-c0b9-304d5716c225@blastwave.org>
Date:   Thu, 23 Nov 2023 21:28:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: =?UTF-8?Q?Re=3a_Fwd=3a_sign-file=2ec=3a149=3a17=3a_warning=3a_impli?=
 =?UTF-8?Q?cit_declaration_of_function_=e2=80=98ENGINE=5fload=5fbuiltin=5fen?=
 =?UTF-8?B?Z2luZXPigJk=?=
Content-Language: en-CA
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Kernel Keyrings <keyrings@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <1fca50c4-6d7b-4c9b-bcea-4df17e2c2e7e@gmail.com>
 <e110cfff-08f9-4bbc-6b69-0d67ae6562b6@blastwave.org>
 <164a4d4434e77ba1b65624a081799a073a3aced7.camel@HansenPartnership.com>
From:   Dennis Clarke <dclarke@blastwave.org>
Organization: GENUNIX
In-Reply-To: <164a4d4434e77ba1b65624a081799a073a3aced7.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-oetec-MailScanner-Information: Please contact the ISP for more information
X-oetec-MailScanner-ID: 3AO2SFvu006653
X-oetec-MailScanner: Found to be clean
X-oetec-MailScanner-From: dclarke@blastwave.org
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/23 09:53, James Bottomley wrote:
> On Fri, 2023-11-17 at 00:34 -0500, Dennis Clarke wrote:
>> On 11/16/23 18:41, Bagas Sanjaya wrote:
>>> Hi,
>>>
>>> I notice a bug report on Bugzilla [1]. Quoting from it:
>>>
>> <snip>
>>>> Not related to
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=215750 but I *feel*
>>>> that this code needs a hug.
>>>
>>> See Bugzilla for the full thread.
>>>
>>> AFAIK, this looks like a bug when the kernel is compiled against
>>> custom (non-system) version of OpenSSL library.
>>>
>>
>> I do not know what you could possibly mean. There is nothing "custom"
>> about OpenSSL. For that matter the gcc compiler I am using was also
>> built by me. Works fine. The sign-file.c source compiles fine.
> 
> This has all the hallmarks of an openssl compiled without engine
> support; is the symbol OPENSSL_NO_ENGINE set?  And which distro did you
> get this library from?
> 
> James
> 


Its okay.

I can fix it.

To work with new OpenSSL 3.2.0 and old stuff .. for a while ....



-- 
--
Dennis Clarke
RISC-V/SPARC/PPC/ARM/CISC
UNIX and Linux spoken

