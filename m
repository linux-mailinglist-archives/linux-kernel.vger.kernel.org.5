Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6747AC06E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 12:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjIWKZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 06:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjIWKZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 06:25:45 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F22F9E
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 03:25:39 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 4fb4d7f45d1cf-533c92e65c9so558134a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 03:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695464737; x=1696069537; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ilKweYsUtdx0uQMw5Lw8exOXx9PByS/ip7ajJiMO4g=;
        b=PvSm8o9yI5uJswJ2TAYIR+Nmoc2O5+LwCkT1VaFNsA7PFoKajKQmaLf6TUO663UHCs
         OV8pcuiQ1ZqlJP8tqCmAl8HQw4ViivC0lO/37AejBn/sktTG4pZGbfzqbYAio24JD/xc
         VCDlxjBt3oeQ/y14Tv+qfAFZYxuRgZHdsSTeVdognQ/kP/itezuLLjcrlb9qgM8Bb1Kc
         M6x8avW66jyS1POQ59RrKBOiUx1xuQC9BwAAwzAu4FNa+3z0H3U03gIr+/6NtQ5BwfND
         lgOyOxVFTOjzcuLayvLh48PBtyWM1+b7BmAAFP4PQ1ga9gv5HbmbR/6FuJ+sQiREnYb5
         toeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695464737; x=1696069537;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ilKweYsUtdx0uQMw5Lw8exOXx9PByS/ip7ajJiMO4g=;
        b=sFl1GeHEZlHtMc3d7zM/r/dxFCm8erdoBkHRKwepBbIBCCOOfAG3Zmt6Gyf4mVGG8F
         OkUDaB6mJY34JLVL7COnK/N0z1LHW/GfxmxP3nQEdPhSMIIftt7MIhmVFqIIVBbnV/M4
         /XbyulFQYw59oM/eT0Ar0XL/3VS5MZ0rrq6iHOAa623I2xYLO99C1C0ZHYGQsceyhmXX
         omrsElGDLGgDp9WKL0Qa0/JdP1ccisBdwPW7yEgIDRGTqYaaSBYZ4aByRDEDxSawszs2
         UVjNMTPv9953L+iQrzLU1zx2UcDzUjaqOLhEyaCxfT92+p09NF1UYSvd879LqduGOJu/
         o0wg==
X-Gm-Message-State: AOJu0YwKcgsuTtcONyVVQr0YbawP8k2AyULUEIpcZhDBJpJfTa9D94ke
        B31+V//7OwcK/1msx9nCR/1qoCFGznVrSNceyCo=
X-Google-Smtp-Source: AGHT+IH0Ho+smv3MOQ71AV46qG7Mb2/jOsXwrnFBwtBMvApYYHQdN9E1ugYfqKP6+gCIQrBCKty3YCUxuZNNhwOo2jQ=
X-Received: by 2002:a50:ee89:0:b0:533:6ffd:a1a with SMTP id
 f9-20020a50ee89000000b005336ffd0a1amr1452952edr.33.1695464737357; Sat, 23 Sep
 2023 03:25:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:8394:b0:5a:5192:a6b5 with HTTP; Sat, 23 Sep 2023
 03:25:36 -0700 (PDT)
Reply-To: sshahar536@gmail.com
From:   Shalom Sharhar <shalomsharhar@gmail.com>
Date:   Sat, 23 Sep 2023 11:25:36 +0100
Message-ID: <CABy7qF7Jsqy0acid_Pc_iBUfV2mSHJR_ovMsp1BrStyy0iL9kw@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
A mail was sent to you sometime last week with the expectation of
having a return mail from you but to my surprise you never bothered to
replied.
Kindly reply for further explanations.

Respectfully yours,
Shalom Sharhar.
