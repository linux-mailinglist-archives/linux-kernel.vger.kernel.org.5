Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6080D7F3D02
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 05:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjKVErs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 23:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVErq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 23:47:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE70F4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 20:47:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97637C433C8;
        Wed, 22 Nov 2023 04:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700628462;
        bh=RI6M9xEbhPfKHmCxWYgz352YqmJ/ZLpTnwPJ8ATtxVI=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=dlzj0bYDKXeSVNOhbvioDXzV3bJiD78y6ilyFp/Hx/QEr4f6hCdTHbUmZfcntzMC2
         JAGHW8ONV+8tsKkdFTS8qSAFT3heCDTtMdVH6SDzNhHNiAGOJtZwCg+OQXyRbcUD2B
         vqm2c3+e0QzKNl4I9pAMlpckLVrYyjtlCTaeoORi9jztHJGZLZL9bST6nQ62YpvdKs
         NpSbm7gLGysuZok1YAdYshmS6oUwq9/iJ/V5l8yG02v22U2rJ2PIIQ+UlAPVe0N/86
         yrfP0WOX5Qlo0EyflIGCDolPdpc5Kzaqqwp3HvDY0Qa01KWOEXVT3pfLIoLNpazyZ6
         vH5kwLNzXekfg==
Date:   Tue, 21 Nov 2023 20:47:40 -0800
From:   Kees Cook <kees@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>, ndesaulniers@google.com
CC:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: refresh LLVM support
User-Agent: K-9 Mail for Android
In-Reply-To: <CAK7LNARAvH=tWpsXJ640y04Ju8UbPmDze_NC6ax1EKK4Xy73fw@mail.gmail.com>
References: <20231117-maintainers-v1-1-85f2a7422ed9@google.com> <CAK7LNARAvH=tWpsXJ640y04Ju8UbPmDze_NC6ax1EKK4Xy73fw@mail.gmail.com>
Message-ID: <5EB120AB-1F30-4403-B652-DC0D2772B25E@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 19, 2023 9:17:20 AM PST, Masahiro Yamada <masahiroy@kernel=2Eo=
rg> wrote:
>On Sat, Nov 18, 2023 at 4:24=E2=80=AFAM <ndesaulniers@google=2Ecom> wrote=
:
>>
>> [=2E=2E=2E]
>> Wake me when you need me=2E
>>
>> Signed-off-by: Nick Desaulniers <ndesaulniers@google=2Ecom>
>
> [=2E=2E=2E]
>(The patch was addressed to Kees, so I will not touch it=2E
>I think he will pick it up=2E)

Yeah, I will snag this soon: I'm out this week for US Thanksgiving, but wi=
ll get it to Linus shortly=2E (Unless someone else picks it up before then=
=2E)

-Kees

--=20
Kees Cook
