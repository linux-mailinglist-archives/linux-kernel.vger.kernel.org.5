Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026DD756293
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjGQMOM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 08:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGQMOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:14:10 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96BC118;
        Mon, 17 Jul 2023 05:14:09 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-57688a146ecso44931387b3.2;
        Mon, 17 Jul 2023 05:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689596049; x=1692188049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbTeCS9i8dp1Bn3oI7/rX6Wt2FAP3Mlu1K2EnaY7mGE=;
        b=Yo3zC71I6R5RgBn5/yS2dOaHvqHWHY6jWziE92HQ3UVKNNaqwTokuGUuskd/Txu/7F
         S6dFRbIktWfGnFtgD4YO69OXhTsz2eCY+uXE6A0rlchHWLv9AI2GcLVa/TbEXoNaHete
         ZB6BBvdh8DGfmhouMBeV8GeSR9JlEdX8vPZ04n8WyUWTqoZThHd9IKjZa+phUXrXl2uP
         zpvIe1Ap745Dr2Sa/YcaxMkhHkVTt+rORV2PoSoJbM95+AAPggsPzGPCsfCrqX6JXWck
         Kh9HImiEUNF5EUpi1PF1grxvdRUwvk+iUdbCcK786w21aN2WhkPe+ODdt61cU5oWhXJc
         a+hQ==
X-Gm-Message-State: ABy/qLZv31izG3Oe6qKeGCl4e08SJh6QqjkkKUnsghCa5zGJT8qs/eaI
        Tdoa3HLtC3FhqPYH/kfARoYTwXzxy+Db3g==
X-Google-Smtp-Source: APBJJlEGXgiwwnaOfsd781OC8hrEPJeuNs0J8kVPKtb3rHR3RvCcEuzqCgL4EMsazc74+9Y76I3foA==
X-Received: by 2002:a81:5455:0:b0:577:3b66:441 with SMTP id i82-20020a815455000000b005773b660441mr12011672ywb.50.1689596048796;
        Mon, 17 Jul 2023 05:14:08 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id e1-20020a0df501000000b0057085b18cddsm3815456ywf.54.2023.07.17.05.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 05:14:08 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso4474602276.2;
        Mon, 17 Jul 2023 05:14:08 -0700 (PDT)
X-Received: by 2002:a25:3491:0:b0:c85:d8b6:c21d with SMTP id
 b139-20020a253491000000b00c85d8b6c21dmr10139859yba.31.1689596048265; Mon, 17
 Jul 2023 05:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <cda2b9ee52a49fa3904d209097754cd757728a4f.1675160668.git.geert+renesas@glider.be>
 <c82c6308-2b32-fe19-e40b-5853544e1c9d@linaro.org>
In-Reply-To: <c82c6308-2b32-fe19-e40b-5853544e1c9d@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 14:13:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWLzRL3_3ae3Y+xyN8QQRA0do95T9QhqkCGPa93QZ1LRQ@mail.gmail.com>
Message-ID: <CAMuHMdWLzRL3_3ae3Y+xyN8QQRA0do95T9QhqkCGPa93QZ1LRQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: Drop spaces before TABs
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Jan 31, 2023 at 2:15 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 31/01/2023 11:26, Geert Uytterhoeven wrote:
> > There is never a need to have a space before a TAB, but they hurt the
> > eyes of vim users.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
>
> Applied, thanks

I still don't see it in linux-next, though. Shall I resend?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
