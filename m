Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7128E7A72C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjITG2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITG2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:28:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CAF9D;
        Tue, 19 Sep 2023 23:27:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAD2C433CA;
        Wed, 20 Sep 2023 06:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695191274;
        bh=aKadO3U4TnL2TXTxl4CJlXU+DprvIkWeqJzC/Nqz8bY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ob8Fj0WQej79SOC8XyqOwwMOcuf8FJssGyl8FfaUE9IMgbGM1dd3Z3jl7J1pCKRMQ
         TKb6ycUEcAefJpSo9Hwa2F36Y+AY57nDuMPl0YhrIj9v1hQopKOm1cN2pqj5P5uJQm
         +REsQQzJRypBMo7d8iASl4i6vXLGvYQja3iKK2vO4pO5XkdTsEaj2IX5IPqmdpIbNj
         GLAOjxlP+eLiMelWhpysr2TRYRl2jW1zNm4UuuC8sHM7RjSv8XoWpz9PKD7uOUKKJZ
         krbFBrpEZVioMVAidW13/TKPnh7wR+f6uI9HXUGd9/VRMgZpYJvRFYTTV+CDUZUIN9
         lRm6mHPwnCgSQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-532addba879so1219010a12.0;
        Tue, 19 Sep 2023 23:27:53 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy2/nOo5BItrUC2HXZgUbx/zLYSpLgmg4xmcKsHze/8+m/EGig7
        VgeYMY9FQ+N084tB1jJHdXrUbexLO38ege8FMRw=
X-Google-Smtp-Source: AGHT+IF64244Hk3wdFHeEi52bl20YWnvHxyfaFIZqydi3XW+5eIdjSeULQiRM9dvLux5ZR38SnscT4wHQ2DEe7RpCgA=
X-Received: by 2002:a05:6402:4304:b0:530:bfb6:66cd with SMTP id
 m4-20020a056402430400b00530bfb666cdmr6449027edc.7.1695191272461; Tue, 19 Sep
 2023 23:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <1695113866-20120-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1695113866-20120-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 20 Sep 2023 14:27:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6jUBHQL-R-3SriF7R5Y5O7P2SsH8mcn6LsC4kmfZRWeg@mail.gmail.com>
Message-ID: <CAAhV-H6jUBHQL-R-3SriF7R5Y5O7P2SsH8mcn6LsC4kmfZRWeg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] LoongArch: Update the links of ABI documentation
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, loongarch@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

Queued for loongarch-next, thanks.

Huacai

On Tue, Sep 19, 2023 at 4:57=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Tiezhu Yang (2):
>   docs/LoongArch: Update the links of ABI
>   docs/zh_CN/LoongArch: Update the links of ABI
>
>  Documentation/arch/loongarch/introduction.rst                    | 4 ++-=
-
>  Documentation/translations/zh_CN/arch/loongarch/introduction.rst | 4 ++-=
-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> --
> 2.1.0
>
>
