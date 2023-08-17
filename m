Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559E677FF4F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355043AbjHQUw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355017AbjHQUvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:51:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1353AA7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:51:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe389d6f19so204987e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692305494; x=1692910294;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74GlaUWpOuTA0MhN5VZiM4NKezqQZlM+zhhkyJSJmPM=;
        b=F577ohvCOpg72JvVGeJHsLkJkNGaO1PRrrhWEVwO5VgnlOkQEXg9OsH8goUePLb9J7
         lK0Qg8Vo8OZsEgY0ug1/Qz9tWN7WpSzaoAv4/X2r7rxBzKLb0zWQWj8AZ25+DNIG+84H
         JoVKKo3LuoYl+d5ZA6ToOrdc1/xmn6WTZTfH4gsQ/fzCtMtV6wZmJseXHpH/sf3AwH9C
         brO0D2dOin7ioxUwE9hfHRfjP9FKmMsX9vinwdXUMLl/HFKosGZZmU5AoSB10bKYD58D
         rFTIZ2BCsyOcQmFfjba6+ayYAUpdLdfpEnVGGNJuiwMf5a1Nd38vdJSMTeOOpE8dI2B8
         +9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692305494; x=1692910294;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74GlaUWpOuTA0MhN5VZiM4NKezqQZlM+zhhkyJSJmPM=;
        b=eYdicwB6pSbjM/Ou76LQ23kahpWK9fOvHScDA3RI7AFUHik+eZ0zDijdsqisslY/Kn
         DIF2SC3gPYO3XTRFG6W6jUGJJm6ABCJsM3syoD6TpqzbiSBjfKp0dAi7s00Go6IpTmmh
         EeWuU1fkrRenmXgPf+QUg94h50NxHDVuxEebOyXNKebq4LNNgTZ02KnzW9iFJ8EZjO2g
         5WvCrQ524vC6G/tcB6JbfhyrNM19oTS2U8Oa4fGwpe7BvoIyUYMZW6ORWo1QzgwFUG5+
         ujWGHm8+Cv1dZ4nRI3SiJNhC+CUflBmM+Z69M4LjSK1TWSrMuHqfyF8wYJ2JnCYF/9Dw
         SxUQ==
X-Gm-Message-State: AOJu0YzrOXNs3KknFFMExiRanVYg/rQXrnCNJv8fTMQS2+6bsOqcJOgF
        CO5R6tmQvnupljdjKudbhWQq4nD1KI9JC+kiFYo=
X-Google-Smtp-Source: AGHT+IF6gZU3cPRYtFl/4G8ccc82OVpA90WlGzsHAQfz9fynGmrHSbJz/lfhrXX/exNTsKckyu14cWttzA1kXvDrik0=
X-Received: by 2002:a05:6512:2024:b0:4fe:17d6:af2b with SMTP id
 s4-20020a056512202400b004fe17d6af2bmr256883lfs.42.1692305493599; Thu, 17 Aug
 2023 13:51:33 -0700 (PDT)
MIME-Version: 1.0
Sender: zandaicvises9@gmail.com
Received: by 2002:a98:b603:0:b0:1ce:699b:639f with HTTP; Thu, 17 Aug 2023
 13:51:33 -0700 (PDT)
From:   pernille <pernilleerenbjerg164@gmail.com>
Date:   Thu, 17 Aug 2023 13:51:33 -0700
X-Google-Sender-Auth: 9Y9HsBIQPSDAgkYI2Y1n0SGvTIU
Message-ID: <CADgrzVuu-AdpoYv-ewwJreQw7jLtAnD1X1-bBZJ5P3i2CpmN5g@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
I've been trying to reach you, I have a business proposal for you contact me
