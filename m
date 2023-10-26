Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7987D82DC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344937AbjJZMnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJZMnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:43:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A60310E;
        Thu, 26 Oct 2023 05:43:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9118C433C8;
        Thu, 26 Oct 2023 12:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698324213;
        bh=K8fE6V/HqNSrlUoE3GWJMPVYVv/zt3hFu6I3c2qhi3s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L+xLvGWVfydzSScFNZsCMFGgsZZijpMF6uiQDgndDInM3P5KEyU0slbXJe3oW+YZB
         0CNpuTtMekXsRPLQFUGElza8YP7UtuIpdas+FYu+JUz3Sn+7r6Y10kl5t4r0nirFhH
         G3JFNAT99Gd/NmNfGOtfvas1HmjrIfVf0Mab8ZHDWO6QgFJ1i7/ufYE1dj3Nb73MJk
         QIDwzrZY4Dt+P8WystfdLvqGo1qstl2K1UQkU19bTx18z8a4ZvUlK429ZYXvO/glOz
         p3C2gRvYVDOzt10//2AlXPStFZHpSDp9Wegv7yh+05kZoFxMcBUKGkXDmx0eaVLSb8
         uVy6Px3h6DKGw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-507a3b8b113so1212525e87.0;
        Thu, 26 Oct 2023 05:43:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YzIII/CUEdja7l/w6KGQVHOJKtYDQiA7fBf1KPRP/ERECfkSLlW
        h5tdVodUYUukZZ9a0qeyQVO0I2vV19oxOzZwVA==
X-Google-Smtp-Source: AGHT+IEh0/XiN3pVk3vZEJYLc8l1SFQL8xO3YYecI5RenBhqNvEbM2d0U9HpmQvH/KgRqoq4wkCkJK26Sdk6QMKXa4Q=
X-Received: by 2002:ac2:4c16:0:b0:503:3700:7ec3 with SMTP id
 t22-20020ac24c16000000b0050337007ec3mr12883347lfq.39.1698324211849; Thu, 26
 Oct 2023 05:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231026081930.6b588920@canb.auug.org.au>
In-Reply-To: <20231026081930.6b588920@canb.auug.org.au>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 26 Oct 2023 07:43:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJJDfrEwOoPic-27USutJwyKBMFuWpsighQzthXUmgBVQ@mail.gmail.com>
Message-ID: <CAL_JsqJJDfrEwOoPic-27USutJwyKBMFuWpsighQzthXUmgBVQ@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the devicetree tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Wed, Oct 25, 2023 at 4:19=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> The following commit is also in Linus Torvalds' tree as a different commi=
t
> (but the same patch):
>
>   460babc96c13 ("dt-bindings: irqchip: renesas,irqc: Add r8a779f0 support=
")
>
> This is commit
>
>   977f7c2b2756 ("dt-bindings: interrupt-controller: renesas,irqc: Add r8a=
779f0 support")
>
> in Linus' tree.

Now dropped, thanks.

Rob
