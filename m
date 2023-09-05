Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23F4792C7E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbjIERby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjIERbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:31:33 -0400
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC3825EAD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 09:57:08 -0700 (PDT)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-1ba5cda3530so2179991fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693932961; x=1694537761; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KF9jy66K812i/KOAycoaswZOJPkoHyr11P3pLmaBV84=;
        b=FKc9JGInhgQtkjpFu3B4jt54eCgQjSRMnAfFLqViWzMx6mqzN6G9rwzwHLK7HDmv0L
         OCbFFeMZ73VKvOUXw6IVgWTpZgcx0Tceflxxu3N8/nqZNoewP6g4UQ5bgQHkZ4F6RHVC
         8OK9QNJkunjsaznkTWO6flzYASL70k4JFVj7KkJe1leh7ZcmERV3D6LNWWj414vL3jUY
         clQHr4RgKzXDO3O39+VU5Nan5+X0OjR9GEOMUCxWuNWq3De2/j/9PcI/QuR5vgSLHD+Y
         wqiWEp6PdL9PZ5F4Y4gszwHJdcidrg4KcsQrLP+iEcof4Y7gTE4U4h7pP8CV0z2aRj74
         mQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693932961; x=1694537761;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KF9jy66K812i/KOAycoaswZOJPkoHyr11P3pLmaBV84=;
        b=X22PVLGx/7So6itsIMbdT6IU3AeCBl/xu28TijB2YVAF5KXA1pu3pFHgPxfJVymZnc
         SfEHXs/PCg1dwvWAocEq2lFB2L/3LUwT+h0UrKJq4PrYSL3t+gsIhJvZ4xZXb/y4INnX
         33qMyhpYNT7PEFPd5ZxmWDfEgxKGvby4AyXsZxVPFEGfMTKlAb1iYvMPymPc++iI4r/F
         14lL5/EHLao2XWxIYXOOcCGOeZoK3DgwF4ykfVWXbtbOKxwWmNsd33AAuodTilJUnSG9
         yTM1YENQ0xHd2xGZtWuonLOUZAZqZ/lq0RJ1DB3wcCuN6GLMagKh4Hj56etWCAnImZH9
         yDEA==
X-Gm-Message-State: AOJu0Yw7IDdBjQDyAFRhZKQziSOTJnCHO9Y7UaeJmHLw9UvBlM/nyZaV
        uH4fo896XPNAk983O3FnbrGpBf2wRvVsVLcEoJLQjHDrJ8qjbZq4fRM=
X-Google-Smtp-Source: AGHT+IH1XZ5x1wvYb9wC2NYnoIWK3GEGTtrNNnR9T34UA/yHtbZloDweM4DejWIdxIKTK9Zf6Qx21p9I1RKmwfI602c=
X-Received: by 2002:a67:fc08:0:b0:44d:4c28:55ca with SMTP id
 o8-20020a67fc08000000b0044d4c2855camr391871vsq.16.1693932228932; Tue, 05 Sep
 2023 09:43:48 -0700 (PDT)
MIME-Version: 1.0
From:   Jodi Gray <wwwmarketingproductleads@gmail.com>
Date:   Tue, 5 Sep 2023 11:43:36 -0500
Message-ID: <CA+9O=BUg00Gu=TVQd29BbhVw6iZ9Ho-GJnkJ+E=DPhBUpybDNg@mail.gmail.com>
Subject: RE: Verified Dreamforce Data List - 2023
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I trust all is well with you.

Are you looking to compile the 2023 Dreamforce Conference Attendees Databank?

The following information is included in the data: Organization Name,
First and Last Names, Contact Job Title, Verified Email Address,
Website URL, Industry, and many more.

40,630 Verified Contacts are present.
Cost                             :  $ 1,826

We do have an all industry list and conference attendee list from
across the globe

best regards
Coordinator of Marketing Jodi Gray

Please respond with "leave out" if you do not want to receive
communications from us in the future.
