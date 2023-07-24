Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F675FAD7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjGXPdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjGXPcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:32:54 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EF71993
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:32:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so6846737e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690212758; x=1690817558;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWkV50YOzgQJBdohl3s0zg3/xIEHH7MV3ugGVsiWbUo=;
        b=ifNjXhunUhfkLZXOktokrkA99UiMoz0a+mePolB1SrXmHzDvlVElH5K+Z94VbkxElo
         k8SkR8pyYTKV3ZmGdgGg/Z3VnKA5+o0icyqTcPwUcX1xrG4wPtthfNfDYhLMczjexSdJ
         Rg9zMqCvWH8b+zK7Mijwlyg0kdSxbYoWu9a2rvZ/NgX7MGSJuWATRUTBkudPFLxobBNN
         BSrh5bMQkgo5VU9e32bxO+crxsBSBdiiCD4wqKSkoTToT9vkLtNoadDAQzmJUbX2XUBa
         f93bo1sBBf/dTuVPNFr7PYii22rsCJMfSGf2nbP4GBVuMTVuZQW5YDOBtGWKA5VS52cx
         LApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690212758; x=1690817558;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWkV50YOzgQJBdohl3s0zg3/xIEHH7MV3ugGVsiWbUo=;
        b=XsMg/Zh7jpwBLnILyIH+fkOy9WiBhZrF23LtYJLKNpAXksgNwMJvzPO4e/dgJBhOM2
         bIDy+ULMzRjHN8CSaWBwGisxQaz1YMOHRqQsATjaIJsEem2CW3vDBCEP+GZdbdhtS9/X
         SR1l6zhdwEte0KPr5+Pmf6ZmaanUsX1V9kzepigm/OiYVHWnJZUwSrVy9Vyp0DJ2jfWy
         OnSYoowmLmwEkF3G8++1TDto8TmyuzHDYv9m/sAIvR9JECz5fqBH7Pa1DHgriV2rPyiS
         cvqU5sHooLfk7fxgy7tAg3OfMpwMgZa7n18x4RGv8PKSJiw5HnMTy1EAo5HP6lOoIMl8
         JEQg==
X-Gm-Message-State: ABy/qLYjn3K7lRJ7LxrbIx1YLoJSUudgNUHOKrxvIBbaidwbomOciXJt
        zSyAETdVykmYOjGx6AeInq/oVPSKCwYt42Ma6+4=
X-Google-Smtp-Source: APBJJlFKYtv5vmAZNAlI3XLrRkamY/bbtNe60okdEdieQte7fZYR3KrsPtSbXhFVnPHKRMiDPFh9ebRMqhVJCqp4XBY=
X-Received: by 2002:a2e:874c:0:b0:2b6:d7a0:c27d with SMTP id
 q12-20020a2e874c000000b002b6d7a0c27dmr6564358ljj.37.1690212757351; Mon, 24
 Jul 2023 08:32:37 -0700 (PDT)
MIME-Version: 1.0
Sender: mastercardsdept@gmail.com
Received: by 2002:a17:907:da0:b0:994:566f:698d with HTTP; Mon, 24 Jul 2023
 08:32:36 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Mon, 24 Jul 2023 08:32:36 -0700
X-Google-Sender-Auth: h5HZlPGE53_uGVp7rkoEAKTqO50
Message-ID: <CAHLGn615m-w-U1hH-FNH7=53BHj0rny9_Go=n9XdLSuLB3yt_A@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dear,

My name is Dr Lisa Williams from the United States presently living in the UK.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

With love
Lisa
