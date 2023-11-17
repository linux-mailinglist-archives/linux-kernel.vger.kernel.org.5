Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74977EFBA2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346298AbjKQWxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346275AbjKQWxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:53:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B78194
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:53:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920E3C433C7;
        Fri, 17 Nov 2023 22:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700261594;
        bh=fYfdWTUVkCPyxIsQpwaVzldzkEf3EyKbHITL/LAApho=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=WZXeKAOmxCi7Aw6m84HAOHiTPIrKA8ERE4ElvYNyhlIJCnvUxKPVwkmM0aGapkI7G
         hq9oO4VNuSld3SxuNo3V2/Dz9DmNfap5st64cJznQh0NzSJvcSwKM08CyKkZNzzhdi
         24Rkl+YNgHG4O0i19w7kYdsK6Oz1H0Y8VSWJXi8RYKj32rFvYbQAUqd0TOidWiafid
         UeXd9cCOdX4z0rGnW09JMJtDS/qIW3mGAqEtt91Xx4B1RDLZm+NoXaSQD2K7grtYZd
         b+eVOjGB9B3rDnafI+NTD/bpmxy+gxQkw/FFEW26BVSQoaSrADboIho/JzkFUKiAhv
         R0nMiVX8/ZbJA==
Date:   Fri, 17 Nov 2023 14:53:12 -0800
From:   Kees Cook <kees@kernel.org>
To:     ndesaulniers@google.com, Kees Cook <keescook@chromium.org>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] MAINTAINERS: refresh LLVM support
User-Agent: K-9 Mail for Android
In-Reply-To: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
References: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
Message-ID: <8243E862-CFC1-4658-B07E-9FB87E34E12B@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 17, 2023 11:24:02 AM PST, ndesaulniers@google=2Ecom wrote:
>I'll be taking a step back from kernel work

NAK ;)

>to focus on my growing
>family and helping Google figure out its libc story=2E

These are both big challenges, worthy of your attention=2E :)

>For CLANG/LLVM BUILD SUPPORT I'm bumping myself down from maintainer to
>reviewer, adding Bill and Justin, and removing Tom (Tom and I confirmed t=
his
>via private email; thanks for the work done Tom, ++beers_owed)=2E

Thanks Tom, and glad to have Bill and Justin stepping up!

>Wake me when you need me=2E

As the prophecy has foretold!

>Signed-off-by: Nick Desaulniers <ndesaulniers@google=2Ecom>

Reviewed-by: Kees Cook <keescook@chromium=2Eorg>

We'll just report all issues as LTS kernel bugs and use the MAINTAINERS en=
tries from there=2E ;) We'll miss you, but you won't be far!

Good hunting,

-Kees

--=20
Kees Cook
