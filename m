Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28EB7816C7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 04:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244244AbjHSCmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 22:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244247AbjHSCmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 22:42:38 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CB13C04
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 19:42:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b962535808so23999401fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 19:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692412955; x=1693017755;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7acdhpg3sia0HTiOORSZxWs0IKp/G5AcbjrZmqozbxI=;
        b=oX5r2xZZwdR6QtRQyYMTGWMaU2GzGyc2/EarYg0cXvNqHQK7NodcNNjBOTzjxs8xA/
         ZivxL3zxvnlV/W0JdISCX066p1FcF96wPBwoZCFNfRW3k3kxUNio+eX+JEwzDv22NOLS
         zO7QIz9FvTcQppMCEw9mVN6qZiUafG6Iy6/3GPej80tX1OqSiaUB9GJex9cYt4fH5z3Y
         At74OIBxgCiTCpIQSRNUfpuWt4stkwjwny0XEVnKmOYuyXhmBZx8z9eJyqZRTlBe/PMa
         PIm1WPMjglg4pm6irxS62rLOkoRCy8s+YopcXygUpkUvruz/yNAf925ir8UDgjIz9lM+
         OxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692412955; x=1693017755;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7acdhpg3sia0HTiOORSZxWs0IKp/G5AcbjrZmqozbxI=;
        b=YbaSx63q2dIl0oDRFjcCLZbeEJtaY4DLzu49l0p6A5E7Q5DSzvom3BXJCep5VuYtU4
         zlIzbsPPUY6H23zY/5BR/NDxYKoxrolrk3YtA97BmCKC8yOPm6W+D2T9cnDSoFGR1zVV
         eOS0NT5ccs0Dcv3IHbg7wql9cV6afNSUy11LEYMbPCu+X5jLQ3YCBLm27Pdv/M6pIONj
         Eacj0jZ5XNucFi2JdaNIhFK8qcvCloCVJTKDmvH+CqXkD4k4jrWwXa6AIb1sV8TLP7uS
         jbrXZ4OW31D9IFQkgkanh+NTS1J23xZY6NzHxTjl13g7Su+gZjFpNZeHQaNig+so7cqg
         ls8Q==
X-Gm-Message-State: AOJu0YwEjy7T6Wk0Mv0EwaUCbsu4PzyURmBq0T8yAfxZxzWHyhjpYxr5
        LaDz6zaLxMMd/RUgxLtifVCzgGKDy8k6xYIQrmc=
X-Google-Smtp-Source: AGHT+IGQrivof/SO6vpAvOav+P2boAKR0u2M2QPpS/IedinGEZUaOfIs17LgGmDNa/EEQwJJUDfm0IMFWXs4Ad+cRe0=
X-Received: by 2002:a05:6512:1088:b0:4fb:89b3:3373 with SMTP id
 j8-20020a056512108800b004fb89b33373mr728779lfg.43.1692412955366; Fri, 18 Aug
 2023 19:42:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:1482:b0:233:69b6:e3e1 with HTTP; Fri, 18 Aug 2023
 19:42:34 -0700 (PDT)
Reply-To: mohammedabuhamman066@gmail.com
From:   Barrister Mohammed Abu Hamman <btimothykimberly@gmail.com>
Date:   Fri, 18 Aug 2023 21:42:34 -0500
Message-ID: <CAMJXB=txg5aVoaeBa3+QcWukZR_3CZW2e+N6C+6qf9xK27dPDQ@mail.gmail.com>
Subject: Thank you for your kind attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day.
I emailed you a week ago, but I=E2=80=99m not sure if you received it. Plea=
se
confirm if you receive it or not so I can be sure. Thank you.
Yours Sincerely,
Mr.Mohammed
