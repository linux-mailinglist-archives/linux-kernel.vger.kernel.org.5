Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECD8753BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbjGNN1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjGNN1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:27:32 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24FB30F4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:27:29 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id 006d021491bc7-56669eb7565so1873380eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689341249; x=1691933249;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYIua5BXXCDbRKUkvwqKXRQX0fbOuTUscmeYaWPO2N0=;
        b=ZIdFJ+0YVZMXPBkTSMlSlJiSNI/8TpK5ANDXa1fgbFz8Pn0Yb0/n3W4nD2rXdOxOwJ
         RH/Vmu8ScnW4Ui9CiuzTkpoFW7Qo90wSmE3CMU8ZDUdWrg79HpnaUsVQC6xiw+tqFfHR
         lWIvoicaBFPe33AW5ldSBc8ilK7iHhfyVmzGxNT/7bAZO8v//ln0bF3IqZzoQfOhhwdh
         dzBN8DuEsAzCjoB5ZMcCdFQtdILh6t4StzcwGXxUYlXmsy/Bvat5csFur13D/FUK5mUn
         1m4E50rC5Of5kWKNMuq1s0knz0qQASIdxMOM+/8jET6mxGrDMgYw7o+Adyqmlf6p72m/
         yOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689341249; x=1691933249;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYIua5BXXCDbRKUkvwqKXRQX0fbOuTUscmeYaWPO2N0=;
        b=g1I3/zL10Ihkr1NyHtMCEhxqyqfuRkopLQCWl6jCEQTumaOJwRu5ltbMr7Z1Ik1pPZ
         QW/SJg4XPB1F0iWVRqiqu2x6ZCSZ1lJWkXYU5IrkkpyUXdGl+r//gBktSBEIXf/V2PtT
         u5tsLR4iF98LXrqvOvcfCqh8LYL+8m5pnn0akkvZzMcwjLybccrVb3cYcn+NF/sdUrBm
         qrHcXMfqFRju/a33KEaXNJDcIOHukQ3WWddVT0POozw+pS/7hErof4ht68KgUt3uAreM
         LN+vmtJ3Wemw3eKbiP4/81XHuTmigK+4/6WJZuILxIFNNIsqcz2qUpdzlKLcPcwFHJX3
         3p4w==
X-Gm-Message-State: ABy/qLbxlPGVlVfDRB50AY5cRKNzqxryyPh2FrmywS/BnBWv/Yadjm+M
        rCSdHwtoNoofuJohfgj4oAmSqufhs1QuOzvosszn3EtdS4swtfI5
X-Google-Smtp-Source: APBJJlEBl1q6sb4rRBz9pS+NQcIsaMVb9CFurNPZQ2QwrRBf/Hi1wBxgw7loriQHcOiSe4rdFrfMbnkEoheu9FWfjZo=
X-Received: by 2002:a4a:8544:0:b0:562:ff8a:75b7 with SMTP id
 l4-20020a4a8544000000b00562ff8a75b7mr1913719ooh.3.1689341248834; Fri, 14 Jul
 2023 06:27:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:9b41:b0:135:1f3:b66c with HTTP; Fri, 14 Jul 2023
 06:27:28 -0700 (PDT)
Reply-To: saddamh.hussein1919@gmail.com
From:   Saddam Hussein <hermankatarina3@gmail.com>
Date:   Fri, 14 Jul 2023 06:27:28 -0700
Message-ID: <CA+=RUcOtT7amE_O3+HC5LZ7T1P0DHF7R_orjbJoJ+2V5o9dV6g@mail.gmail.com>
Subject: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Greetings My Dear,

I Am Saddam Hussein, Saudi Arabia

We offer debt funding to project owners on a 2.5% interest rate. Reply
for more details.(saddamh.hussein1919@gmail.com)

Regards.
Saddam Hussein
