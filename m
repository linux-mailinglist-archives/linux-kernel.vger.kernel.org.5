Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A2A7A89DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbjITQ6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjITQ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:58:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AD799;
        Wed, 20 Sep 2023 09:58:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0DCC433D9;
        Wed, 20 Sep 2023 16:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229104;
        bh=Ck7L7SaEpfHsqGu9D/bRu3QFPIxneAy3tqqGqLYnVE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GfZqENRBZeHFsGuIZoCEhc7NIQgOz61AYSjGZLnJApRBgkG8qFeuGkMxxiV4IaVCu
         Vyq4l34io6LPGU6U/193O6ppgSu81yrRe7sIiagtUNgalvrS7SGvjMAMvoJeY3WiWb
         +jbkj2j+SobueldkBVmKPuod/lisdPoRsO/lUscl+6HgMCzsfxelUuf9UgeNsm11ed
         WdJ3VTAt63mUmFvjkidmV+L/WEH22bwlMlpNrsdxVVdvauTSfEUj31lkluHKczvboV
         VJtHWgjDSJ1vlIVLjar4Z2zKnV/Ld5+iFid2M8UmdNq8Sw0nZFU0IZbqW+LwgxKNg4
         0AWiptDzEtigw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] SM6375 remoteprocs
Date:   Wed, 20 Sep 2023 10:02:28 -0700
Message-ID: <169522934570.2501390.16587798037129416610.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230725-topic-6375_rproc-v5-0-a8e9cde56a20@linaro.org>
References: <20230725-topic-6375_rproc-v5-0-a8e9cde56a20@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Jul 2023 19:33:20 +0200, Konrad Dybcio wrote:
> Resending as the previous revision was mostly ignored on the rproc side.
> 
> Changes since v3:
> - Pick up krzk's rb on bindings
> - Drop patch 4 (applied)
> Link to v3: https://lore.kernel.org/linux-arm-msm/20230109135647.339224-1-konrad.dybcio@linaro.org/
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: remoteproc: qcom,sm6375-pas: Document remoteprocs
      commit: 6d3211e015b0f236986b16c042f71cce8d36d727
[2/3] remoteproc: qcom: pas: Add SM6375 ADSP & CDSP
      commit: a6df21cf0c93cab57059e2592c7c99b424965374
[3/3] remoteproc: qcom: pas: Add SM6375 MPSS
      commit: 93f875645c9da9c788224964499e68fa9664e80f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
