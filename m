Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F057B4AEB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 05:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjJBDac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 23:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjJBDaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 23:30:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF57D3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 20:30:26 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5045cb9c091so18490017e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 20:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696217425; x=1696822225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxrswed9LXFiMLWzaLJZwhwURVs4ghK//pBojhrWxiw=;
        b=d3fQbsTOlHvLAzHt3q8MBMS4QiWX4slVdZk27NYJGMlZ47XsA1nDfoxKoOLnJBX4+e
         0LS6DqXH7dD/LpSYcWyJNcfSVUBzZmnkFZezI2OghoMFin1SpH9OnAhs9s4h+7RSaLNn
         RHwzaWoSyfIC0ymwgd5CRDSTKtdyEV9Uv7Hcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696217425; x=1696822225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxrswed9LXFiMLWzaLJZwhwURVs4ghK//pBojhrWxiw=;
        b=wfc76ehGaFFeuer9O4VlnVgnPd02wkh39TDqOKdBNgTx+4aIz3nKjpdBynf6xtfsFf
         VYLg5GyTNPsoEwQt2lirEFCAjxdZ6m5yrX3gjgLKgNUd/Q7Ue0A+MdTqGOCYLHh4NeLf
         w+KUkujIJJBzgx1NkkcIVLoc62zlsK9cmB3F39BgozuSc/LZjf3n88+sHRFp1QVXNare
         ptPaFANs0nUC3I/bOCt0Mt8xPst5il0cAnEjj+aR2TCBuAXS4S0ImOaQeLZZ7sirAI6u
         t8Tsai42ysK2021Dght7+xlneH/Y9OGLkUS7lKsE6SsrG+TfKddB9ZFoAPgDK6svUF7G
         ihzQ==
X-Gm-Message-State: AOJu0YyKdbQgDJ3+9oTfay1tw7GFstTU1aaroun6Fu2O76Iac+a+Fr0s
        hQqC+OwDkQliq9SOUZjh8X9Sn3OV4cBwxchu+MSmdw==
X-Google-Smtp-Source: AGHT+IF+QatVocFmRGJXKsFlY239FHUEt/InSagl685uTbNTsTU5IYYV6+uN84C44RNwztMDPSDeexsTiihSb+Hslig=
X-Received: by 2002:a05:6512:485b:b0:503:3707:66ed with SMTP id
 ep27-20020a056512485b00b00503370766edmr8048003lfb.34.1696217424296; Sun, 01
 Oct 2023 20:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230929082009.71843-1-angelogioacchino.delregno@collabora.com> <84b2de54-8337-42a3-a25c-a95cf2f3349f@app.fastmail.com>
In-Reply-To: <84b2de54-8337-42a3-a25c-a95cf2f3349f@app.fastmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 2 Oct 2023 11:30:13 +0800
Message-ID: <CAGXv+5FtBcHwEhQEoEUBx24Zf4ABrDeSaWo_mDbM7OvmBLF5nA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Angelo as MediaTek SoC co-maintainer
To:     Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, amergnat@baylibre.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 3:37=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Fri, Sep 29, 2023, at 04:20, AngeloGioacchino Del Regno wrote:
> > I am a top reviewer mainly for MediaTek SoC related patches in most
> > subsystems and I've also been upstreaming both improvements, fixes
> > and new drivers and devicetrees when required.
> >
> > The MediaTek scene saw a generous increase in number of patches that
> > are sent to the lists every week, increasing the amount of required
> > efforts to maintain the MTK bits overall, and we will possibly see
> > even more of that.
> >
> > For this reason, and also because of suggestions and encouragement
> > coming from the community, I'm stepping up to be a co-maintainer of
> > MediaTek SoCs support.
> >
> > Signed-off-by: AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com>
> > ---
> >
> > P.S.: I tried to reach to Matthias for almost two months, but I couldn'=
t
> > find any way to talk to him and he has been unresponsive on the mailing
> > lists as well.
> >
> > P.P.S.: This also comes after Rob Herring's suggestion to have myself a=
s
> > a MediaTek SoC co-maintainer [1] and support from other people.
> >
> > [1]: https://lore.kernel.org/all/20230804225813.12493-1-robh@kernel.org=
/
>
> Thanks for volunteering for this!
>
> I have no information on what Mattias is doing, but I see that he
> has not merged any patches since June, and that he never sent a
> pull request for your patches that are still in his for-next
> branch.
>
> I hope he's going to be ok, but let's plan for you to take over
> for the moment, at least until Matthias is again able to keep
> maintaining the platform in the near future.
>
> Here is my suggestion for how to continue from here:
>
> - Please send your MAINTAINERS file update to soc@kernel.org
>   along  with any urgent bugfixes you may have, so I can forward
>   them for 6.7. I'm wrapping up the current set of fixes at
>   the moment, so this would be for next week's rc
>
> - Create a git tree with the ususal branches (drivers, soc, dt,
>   fixes, for-next) and ask Stephen Rothwell (on Cc) to add
>   the combined for-next branch  to linux-next for integration testing

I suggest creating a shared git tree from the start. That way when
Mattias comes back and does agree to co-maintainership, or if anyone
else joins in, you don't have to change the git tree URL in a lot of
places.

> - Start each branch on 6.6-rc2 (usually we use rc1, but this time
>   rc2 is a better candidate because of the last-minute
>   drivers/pmdomain rename), and merge the corresponding branches
>   from git://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.g=
it
>   into those to avoids conflicts with his tree
>
> - Add any further patches you want in 6.7 on top
>
> - Send a first set of pull requests to soc@kernel.org for whatever
>   you have merged as soon as you are confident about them,
>   ideally by the end of next week.
>
> - Send additional pull requests for fixups or late features in
>   the weeks after that as you see fit.
>
> See Documentation/process/maintainer-soc.rst for more details
> on the above. When Mattias comes back, you can work out a new
> process together with him.

I can also answer any questions you might have about the process.


ChenYu
