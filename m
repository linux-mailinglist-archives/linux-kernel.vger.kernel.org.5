Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219B37B8AFB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243727AbjJDSoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243679AbjJDSog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:44:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E98AD;
        Wed,  4 Oct 2023 11:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696445069; x=1697049869; i=rwarsow@gmx.de;
 bh=exw4hpL06/h79Gx+biX9vZRZGI29ZtFjxbjx8E2Gw2s=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=ByU84PpjYVI62sWoJnvQErBGV0kwVK6//5/CMRJ5UHVze38hyOyZLVS65OK5odZFgaP9er7oBTR
 9ofBEMKj3EThf6ytFKNLXDCWDz58vV4S//dEpHtkgLt2UtNu/nYJ1/QdJ6WTz0T5C6LCohi3z0Tmo
 HW02k7GA524EB1LKCSr0Td/y5Cnh67GthyTfm1UKlmTu4HY7l9VaCyFuW1JmZ6kAuoxcKFNTOuVfG
 xqFxv3sxtvj9dqHuXUf7330WK8MN6O/ktXM+3uP99lhpP6x+3NYuDPozS8oVkdz2ivQWISMIUnbK6
 8BrRN5HBnlwq9a6ysDRQVroPn0qSrBp6cSbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.134]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8mV-1rHNnt3VTh-00f9dc; Wed, 04
 Oct 2023 20:44:28 +0200
Message-ID: <0b1f582d-5318-469e-bcbe-2733aef61d4d@gmx.de>
Date:   Wed, 4 Oct 2023 20:44:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.5 000/321] 6.5.6-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0BC6hZjoUSknnNiSmC59DOAvVNnYokVyoWnGqsSWMC204HAgzG/
 LmX+hM/lUxAGJfFpmT+kHZni6jjx21zwpqXhnkaRd01ow51F8SXht4w1jWyYekfozbcOMqq
 tDRKgoHsXmchoVGaDdZxhc8qvfkLzAjjlE4z29vOdLL9Qblgnx3uxUDJFxZ9hir0UtigjY6
 IBPt3qsqoyXoZ6nVrbrIw==
UI-OutboundReport: notjunk:1;M01:P0:02yhtwRV9tg=;bKZOl1VR1rQrY/G1l+9NCbPmGqL
 Z7d+SDNiBLW+Vgdk6yRAsbhBv+DDUniqzKgKdbfgZAnMsRdrowJnCle9QbfEjTv6u/FetqTic
 25XciLCXgBPq+pPrfkYso6gR5g2MRHoLUCayh/rmNQun7pig9FBc8v/c3Cqc0zUaF+ElB0FOq
 hCF5ZH+5sfviLSXYvcMxm+vQCJLn962GUDCg4ow166vVz3txx7vJWNhWBD8zABWkI+/AeZRlR
 7nXJyA7baOj4cP9tPGuUgpWf+3m8SqOBAe8Vrtl79iDnwCYTSe6E6OSff4AiyjelXgUWO8ghq
 SnZveUZgbMRhX9Gglv8ogrWPSjUIKGF1srE9XARIa7UbvwVwdxsMAHwj/1TM80F8p7VN41o9i
 T2AnotEXGlAshM0WIKegVbwB31bXg4vOg0BQ72djOkRS3N6g5ERXibzZYX+z4g4UAcyixDKLU
 mVY2slzw7gRHgPMqbbWM34hN/oHq21yJlzMrEZV9YPSlKF1xTJ6L+fEjlBgVfTrnBlj7aEfxs
 6qP4uNE6p+G/LcXFwuZWQyVv3FCufvaEGmt3i6bsYt1OUdeqIg4vJcNRlBV4+Oq1onmJFZRvO
 tActI4rwAJwEG78Q/Eaz7XFmycAwb6Q5NhAwLEwEeuCnvwHEm6s+zqymuAq2dFgfOyT/CU2gs
 FFxiR6Qh5WIMZeVSzkwoaMfY4Mv4m2YVFqwQhHgxXEP+XRuH32ER63k5hqE3PHsEF2CEp7pyu
 3KhXenjWIuvNqWaBxbKli196PRttn31VnEkvfgRrSpvYbi/ul2eYnBddO25lY41UMe7FeT2EW
 WcOTVjK4gNd+lsqbw3ytfM0jaTxYCzAsdO05ITW1dd/yu9MsKPMAq1YKAwAJMAobatGO4crvt
 XNhxFPUZiNABu1Pa57DXV7sUN2MjZ5MJMUQPNgtgwNPSQqHwdORtNtG3a1n2sv7DijSLKtp9l
 801wvhvQA5mX73uC7/5aFw0q4jY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.5.6-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

