Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F94774A13
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjHHUQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjHHUQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:16:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B5314FA3B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 12:18:12 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-307d20548adso4642761f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 12:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691522290; x=1692127090;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eAR8OwHxneGOD6cI9OMaaTZwonF32CaBU6KMe777AfQ=;
        b=GYb0KE38yc0513D306z6euTVYEtRDsXyJDYJF9xtzTY/iEpzNUqk5aCn/pp2gJQwtu
         Aws838RXhY/e2sxx19cqhctw8drI/MWis2wokpmhDIwjXXL7HZSSMiXg/7OEf6UZ13eS
         dPgSxsdTZmbA4yuHH5q/CAV2H2A68dCDhiDSpCbs6WnZFMr2NOmODgZbEB3E/q0R+2Ty
         BaIxfWrSu9gbS3kGfz+jUQpxTuFXliL8TMJ3dQ4mCBas+jF0SO4Nukmpq2qfdke46m0+
         9iqzI4avsA6eYVbZaECiZ9YXE4dtDvNwcfOS6nJIUG6SJG8/dzyLkfKjEKdLUkEZHptA
         W9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691522290; x=1692127090;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eAR8OwHxneGOD6cI9OMaaTZwonF32CaBU6KMe777AfQ=;
        b=DDlt9N4qzUs2EV+FjOIFGcblAXjQeLDgjLXed8qxlkViLqSQh+Pi1oki25H3uErbjy
         wIadVycpUNwTKBicV00klHKKa1kzZnO+9oq2O6bQAcunk3Hfepckk9hUP8p18X68q7Vq
         xRDw9jXQVlPl7UR296ZqeVYSz8v+LLlTCLfMXQtVd1DOPya54xKF3uRAf5eSUqcyrSSq
         amFFbZcgpU/nIYIGu5XkpeRZfLPJSCi9k8caFCOZVYoM+Gz5wiibsILbqN455ZOGWOpB
         pGHTV+/Q6QBQPfKZc+4JF7XkyrAz0U44kn/0fjNeJ7y2wNxtoppG5j1xd/TvGnbCeYqh
         NLfA==
X-Gm-Message-State: AOJu0Yxg30URPnqmzYKsgU3w4Sj5rhAk0ffQSCGJtenqYaDNuJiFoLO1
        O/hnskn4YcuDWpUjXf2SwnZBUK6wbLUh2EQJ0dw=
X-Google-Smtp-Source: AGHT+IFwUhkdpyDx6NkneWEHJHizkzu6HcS0X+J4bhSttR+5Zomkjk6WEZyH/sBch9W5BL8lMAf1TrUQ7vQD8+K5TGU=
X-Received: by 2002:a5d:6341:0:b0:30f:c42e:3299 with SMTP id
 b1-20020a5d6341000000b0030fc42e3299mr270874wrw.60.1691522289657; Tue, 08 Aug
 2023 12:18:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4536:0:b0:317:75fc:c5d6 with HTTP; Tue, 8 Aug 2023
 12:18:09 -0700 (PDT)
From:   AREF ABDULQADER <abdulqaderaref115@gmail.com>
Date:   Tue, 8 Aug 2023 20:18:09 +0100
Message-ID: <CAJNCi-xscokmZ7kVNPZ8oLXwt=fw4XFPBSKu0XQG9yEg_AP2wQ@mail.gmail.com>
Subject: we can meet in dubai
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear friend
my name is Mohamed Abdul please send me your what-sap number for easy
communication i have millions of dollars to invest
thanks
Mohamed Abdul
