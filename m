Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ED978BD0F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjH2CwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjH2CwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:52:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005B5139;
        Mon, 28 Aug 2023 19:52:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93CC562AFA;
        Tue, 29 Aug 2023 02:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFEDC433D9;
        Tue, 29 Aug 2023 02:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693277521;
        bh=2000Dx0x8NNTq7L+dJqIL03ECHKc97oVrelzhqq6/Pw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QZ5ffKhPD1X96SZPyeV4VN9gIYpwU5fZDAizE2VHatDN/MFfEDNsIut0RysqlB3L6
         Y4yyfrJWfxsHrgXlFID71IotFy+HQJKBq7/0JFKJYAb0NbJJRVeXAPJiBXqox2M+Gs
         ykLmQx9yQGV504o220EqgYA/av407zE3LwgfMlp0KqdMslAuJfEhTBvyeZyGvebegJ
         Z1z9YUr63hLI6MUkRqfOQdpsukzELJWZ8/RS7IKY/F6rx94/SHyEFqcfZuJG/4MEPD
         O9Y8BmfuquQFOzraBVTHNztp6X5/urrO5m0ykVtYdPsQPdrJDRuF+rE1UVywnambeX
         W6H+HazCg6Iog==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5711f6dff8cso2356179eaf.3;
        Mon, 28 Aug 2023 19:52:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YwZHUR1xtKLx/cWVGdsx/7r/O2YD5j4gKsMbarGI82o4+MS+/DR
        s2a1zlLC7rkAccQS0dGrKU82zxFKphGLjtuqM0w=
X-Google-Smtp-Source: AGHT+IHh9n2KRQMtYFZZOKN9WQyZD4/Tr4GBxeaC+6K3pNzt9Sh/NcnxYsBVMXQR/MYKkSdKycJPP2Sl6nskxhoY/vQ=
X-Received: by 2002:a4a:6211:0:b0:56e:a1d3:747e with SMTP id
 x17-20020a4a6211000000b0056ea1d3747emr12840728ooc.6.1693277520114; Mon, 28
 Aug 2023 19:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230828-docs_fixup-v1-1-cc78af124667@google.com>
In-Reply-To: <20230828-docs_fixup-v1-1-cc78af124667@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 29 Aug 2023 11:51:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT08zhGgrDWdjKv17S30KPJ++JsBmaCwudTkMAdJR_M=Q@mail.gmail.com>
Message-ID: <CAK7LNAT08zhGgrDWdjKv17S30KPJ++JsBmaCwudTkMAdJR_M=Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation/llvm: fix typo in link
To:     ndesaulniers@google.com
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 8:20=E2=80=AFAM <ndesaulniers@google.com> wrote:
>
> Fixes the following observed build failure from `make htmldocs`:
>   Documentation/kbuild/llvm.rst:127: ERROR: Unknown target name:
>   "reprocible_builds".
>
> Fixes: bda09c0e14a4 ("Documentation/llvm: refresh docs")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20230828145737.6ff53bc9@canb.a=
uug.org.au/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---

I will squash this into your original commit.

Thanks.



--=20
Best Regards
Masahiro Yamada
