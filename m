Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CAE7E0500
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjKCOv2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Nov 2023 10:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjKCOvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:51:25 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF908134;
        Fri,  3 Nov 2023 07:51:22 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5872c652a66so237442eaf.1;
        Fri, 03 Nov 2023 07:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699023082; x=1699627882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhwxPNRnzPfLp4P5cSF6T2WieUBPp/1kC7QjtIXjLHI=;
        b=qhfnW1MUXFG1sy5B/necb3aqOTdB1PgSegm3qOB/9mTQagXBMxWjn4RRZMc5wDaCWQ
         e5fYrwwdyDx6LMj0XgnABpBSpN9ciWdGiLDClYPH5xRKiS35B5qkpJ/4Qk5n81gMetWt
         p1C6xeXRWmeKNcEDDBptAlsGVU6+4QWLkwydQT2vRM/N232AgHjuKkH+sLA+ofG7cykS
         PFJw5HnCLOYbAQ1q1u0lTydxTaVXF+iBYYbSWALju0IO48LOhVf2+v1J2MaQ+SHgtjdj
         obY2txlssOl99c+I+oHsdd9W3CgNjs0e0B5uxIsrReaTcGt18IiHMn424XTQdlid6cxI
         i+cA==
X-Gm-Message-State: AOJu0Yx5syuy5HgOSHctDzu1KFOfHmmoBdftPiMX0CH/rhIL1Ze/cX/f
        /fO2rXf2AmOndqeEW14Nk6UT5eKFxW/Zxo0nsG4=
X-Google-Smtp-Source: AGHT+IHx08Psi/bO9CRj+21PpAmBJ60MUfwmWlMg0TWpsdkzzCDFORDeTZ7o6NjOjWCDc14nkw/+zzv0OExjcib7eT4=
X-Received: by 2002:a4a:dbd8:0:b0:583:ec88:e0 with SMTP id t24-20020a4adbd8000000b00583ec8800e0mr22569573oou.0.1699023082020;
 Fri, 03 Nov 2023 07:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <30046a10-bd4d-4c5d-ac55-f8862f01e141@linuxfoundation.org>
In-Reply-To: <30046a10-bd4d-4c5d-ac55-f8862f01e141@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Nov 2023 15:51:09 +0100
Message-ID: <CAJZ5v0hFtgWZ-bLwtwfa3bySZQj91viqyxuWXT9a=V6A0OCv+g@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.7-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Renninger <trenn@suse.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On Tue, Oct 31, 2023 at 9:46 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 6.7-rc1.
>
> Please include it in your next pull if you already sent your
> PR.
>
> This cpupower update for Linux 6.7-rc1 consists of a single fix to
> documentation to fix reference to a removed document.
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
>
> The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
>
>    Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.7-rc1
>
> for you to fetch changes up to 6feb1a9641197ee630bf43b5c34ea1d9f8b4a0aa:
>
>    cpupower: fix reference to nonexistent document (2023-10-25 10:14:35 -0600)
>
> ----------------------------------------------------------------
> linux-cpupower-6.7-rc1
>
> This cpupower update for Linux 6.7-rc1 consists of a single fix to
> documentation to fix reference to a removed document.
>
> ----------------------------------------------------------------
> Vegard Nossum (1):
>        cpupower: fix reference to nonexistent document
>
>   tools/power/cpupower/man/cpupower-powercap-info.1 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> ----------------------------------------------------------------

Pulled and added to the linux-next branch in linux-pm.git, thanks!
