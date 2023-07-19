Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EF975992F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGSPKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjGSPKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:10:20 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6631991
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:10:06 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-c84fd44593aso7129705276.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariatruth.art; s=google; t=1689779405; x=1690384205;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3jr6vaUcvSMNI4x0zxIRsTo4xguGIaHs6nxZRP4hUh0=;
        b=OGwBVKMwGxqrYmcG75XKr9ujIiTd/Km9VIeMLa3pkvkCN/aaTZLkKBcJPjIuo5G86H
         KI9HXG0TYf1/mxmrAn8C41UjyUUhmsvliD96YJ9oPPyHlsk9ESWAnw2Eie+q99gcC7TN
         NSfmPi56izMtvrCzQZiCUDN2czFlEuNH2HTcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689779405; x=1690384205;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jr6vaUcvSMNI4x0zxIRsTo4xguGIaHs6nxZRP4hUh0=;
        b=QDbACGIBsQSIfk3QduUWv2j/z2IbjoOQDZ0jIOOfg3z3mKLKxmcs7D//HPlEB6dm6M
         4q1CAPkMCdnsLT3a1xhG4mf5aiFwHOj7rje4dEzn4zxf1OnMg7q/U04UZMxR5pAb30UD
         2T8e29ajdE3W/LUgt6kjaD+H+EbmA5g2r5XexK3sOEGyWvBfXaoW9EN6vvT2c83co//F
         byLFkI2jUxF5pay19H4yZMW4h2hhAis1vFNrn57NOmDCEYrjqFRxbjVBsbOO064MJehu
         jRjZiD9jRdg2uuachmyXjoTOnJG5AD2sfuuA+xxUNheAqv7X4IdzdrtdlQAj+W8jt1Cd
         1ZLQ==
X-Gm-Message-State: ABy/qLYWFobZuvwX+x3dsH9atMwOZ1atYmGtqahSbEWPbOhAlKa2Qux9
        yy+nB1EqcUWh1np3j8piJOfwKhukHuRwTZBQpcqFA+hRNK+AZCDJCMKNrBu+/b8=
X-Google-Smtp-Source: APBJJlEkjrmVt0o0dLkSQbK9kBBpDFah8NS5iqvhTZRCKWp+dBS4MODEP1iB8fcSb9UfbT5Gu79UZkmfyABcKT/3k1Ot2ve2hn8=
X-Received: by 2002:a25:bc90:0:b0:cef:f6bb:ceda with SMTP id
 e16-20020a25bc90000000b00ceff6bbcedamr2734040ybk.25.1689779405470; Wed, 19
 Jul 2023 08:10:05 -0700 (PDT)
MIME-Version: 1.0
From:   Maria K <info@mariatruth.art>
Date:   Wed, 19 Jul 2023 10:30:18 -0400
Message-ID: <CAKNe_tCjgGs=mOTW+d-t6PO68OOqcB3RrMvngWMNVpEMXBosSg@mail.gmail.com>
Subject: Review Maria's Books
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

I am an internationally established millennial writer and I'm
releasing my first books in creative/literary nonfiction, philosophy
(epistemology / metaphysics), history (revolutionary), true crime
(speculative), and self help genres. They all have philosophical and
psychological dimensions on social issues. Would you review them?

You Are Always Innocent
You are always innocent even if you think or they tell you you're guilty.

Reality Is Just A Possible Fantasy
Reality is just a possible fantasy and can easily be the other way round.

The Impossible Proof Of Knowing Nothing
Believe nothing. Doubt everything. Research. Question.

I have been published in top level publications such as Forbes US,
HuffPostUK, TED, Wikipedia, PhilosophyNow and more. I have
qualifications from top universities such as MIT, Harvard, Cambridge,
Caltech, California, Sydney, Queensland, Alberta, Toronto, Berkeley
and more in every Art and Science.

mariatruth.art
goodreads.com/mariakarvouni
twitter.com/mariajesty
amazon.com/author/mariakarvouni
