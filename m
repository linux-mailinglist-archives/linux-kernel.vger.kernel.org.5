Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12CC77B0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjHNFbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjHNFbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:31:07 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D12E6A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:31:05 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bd04558784so3527839a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691991064; x=1692595864;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6gpw50arjJAJYutxnBYI251PZ1iO12jHMUjWqVshAjU=;
        b=N9yRWUZ0dY2wHM2E4arp/b79k7UDlfwKyXoSYmZ9KzQftfv6FdCvpuGc1x6dyP8Txi
         eHre3KtvmESdfaMM2EVmprZ4Igiy2+XbBme7JYp88b9fyW8J7C6EB1rKdF48arRBwTcn
         NfFqmWEFGnNADtvCEt8sdTmcJqrYKa+650CIImcqUN+iktsxjrMA8yynp98D/gzZAXzG
         kJQw67xIQD/a3PkF0kTFSC2qePPwzK61dG2rq1rxxzHTmcmPFtpcHnfJPcG0yB4INwBx
         vrPsl+WuokbOU6AVTOdu6VXpUSwAIBnSfHeVIOrz38I5xG47c9tordsYt0ytSl1s2PB1
         ryiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691991064; x=1692595864;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6gpw50arjJAJYutxnBYI251PZ1iO12jHMUjWqVshAjU=;
        b=ZsZM/2pdtyqmYs0Xa+zgCnOVP1t5g5mUWh0+uF5Vy9cEiQp7reYGIdilPutggx2mD6
         YOKZX3V8O0sFEWIZBVl9ibVULksWcz/zbSHGXKh6eSJcBmYb/B2IO72v3ndfPtXidZp9
         KDz2LZk+Ho1MX9gWszEbAMegQpykhcrYezXCi94ARGNKNPnNo4l50rNYARJuZDx3/oG8
         vDDTFBHe+m/et5LiWVziZZnRH7O/5tOVVsUyorolfelrh2II3+Kbgb5ODTi44oCMKT/h
         TgERq5b92pmthfmZAH3sHOD2/MGjr29E5CUhUrQSu5guEmA4S5KqepyxL5MYrBnhGQrf
         6iAg==
X-Gm-Message-State: AOJu0YwW8RuRwZukSK9ltgDgoW71PUc0qVIecXGIhEcoNiYI/dNaXNan
        jeTApcnNiJ0ADoKNqaPhbBuE72QqQw2npZCEr1yqyfxTWc8=
X-Google-Smtp-Source: AGHT+IGD+VFEjbVXTD+M0FMUQjIMgyrJjW5yrVN8pNnigbRYZg/ZQAYd0UBOvLgCII7seFXLgK6pGvjO3nGEiALU7ZM=
X-Received: by 2002:a9d:5e88:0:b0:6b9:b938:3524 with SMTP id
 f8-20020a9d5e88000000b006b9b9383524mr7988110otl.6.1691991064582; Sun, 13 Aug
 2023 22:31:04 -0700 (PDT)
MIME-Version: 1.0
From:   Nogay Adygman <nogay.adyge@gmail.com>
Date:   Mon, 14 Aug 2023 08:30:54 +0300
Message-ID: <CAFUOiQbsLn-HZt2zgfc=SqnRFP-p+vwAhnhrJoEd=3b2GQNvtw@mail.gmail.com>
Subject: rasist - kandidat (+history material)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://de.wikipedia.org/wiki/Alexei_Anatoljewitsch_Nawalny

(+ no work link
http://lezgi-yar.ru/news/navalnyj_razreshit_gej_parady_i_zapretit_lezginku_esli_stanet_mehrom/2013-08-24-1620)

https://flnka.ru/digest-analytics/5673-kto-podstavil-kreml.html

aborigen nogai
https://www.interfax-russia.ru/south-and-north-caucasus/news/vostochnye-rayony-stavropolya-nuzhdayutsya-v-pritoke-naseleniya-v-tom-chisle-za-schet-ukrainskih-bezhencev-senator

interes monument
http://zapravakbr.com/index.php/analitik/1498-madina-khakuasheva-chto-skryvayut-geroicheskie-pamyatniki
