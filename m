Return-Path: <linux-kernel+bounces-13033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB48781FEA9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07E11F21A24
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3379D125D7;
	Fri, 29 Dec 2023 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="hHS9P2KP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A811705;
	Fri, 29 Dec 2023 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 0F40828B594;
	Fri, 29 Dec 2023 09:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703841908;
	bh=vBr77PlPfMNs1GvByaNmBP3bSQKIkAVW8QSD0Z9L7pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hHS9P2KP1Uvpka4tk/Dvb79Hfo9X9pFFVQIkvPUgl8/3hNni6Y2fpJtBa0UwuTmOm
	 EgWZC/oHBS+HWmgnK2xqE9uW+/XY/6m3sBbV1QI3CH3fueFdOLvaeNLYOfL+XrvnuE
	 0aauagJdKOKMKbyZR8uJ7cKVGrjsXsC9GdMNuvYI=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [PATCH v3 07/10] iio: pressure: mprls0025pa whitespace cleanup
Date: Fri, 29 Dec 2023 11:24:35 +0200
Message-ID: <20231229092445.30180-8-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231229092445.30180-1-petre.rodan@subdimension.ro>
References: <20231229092445.30180-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix indentation and whitespace in code that will not get refactored.

Make URL inside comment copy-paste friendly.

Co-developed-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2 -> v3 even more whitespace

 drivers/iio/pressure/mprls0025pa.c | 35 +++++++++++++++---------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index e0a2a60c6245..fef3ca69c4f0 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -5,10 +5,7 @@
  * Copyright (c) Andreas Klinger <ak@it-klinger.de>
  *
  * Data sheet:
- *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/
- *    products/sensors/pressure-sensors/board-mount-pressure-sensors/
- *    micropressure-mpr-series/documents/
- *    sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
+ *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
  *
  * 7-bit I2C default slave address: 0x18
  */
@@ -84,9 +81,9 @@ struct mpr_func_spec {
 };

 static const struct mpr_func_spec mpr_func_spec[] = {
-	[MPR_FUNCTION_A] = {.output_min = 1677722, .output_max = 15099494},
-	[MPR_FUNCTION_B] = {.output_min =  419430, .output_max =  3774874},
-	[MPR_FUNCTION_C] = {.output_min = 3355443, .output_max = 13421773},
+	[MPR_FUNCTION_A] = { .output_min = 1677722, .output_max = 15099494 },
+	[MPR_FUNCTION_B] = { .output_min =  419430, .output_max =  3774874 },
+	[MPR_FUNCTION_C] = { .output_min = 3355443, .output_max = 13421773 },
 };

 struct mpr_chan {
@@ -273,7 +270,7 @@ static irqreturn_t mpr_trigger_handler(int irq, void *p)
 		goto err;

 	iio_push_to_buffers_with_timestamp(indio_dev, &data->chan,
-						iio_get_time_ns(indio_dev));
+					   iio_get_time_ns(indio_dev));

 err:
 	mutex_unlock(&data->lock);
@@ -351,7 +348,7 @@ static int mpr_probe(struct i2c_client *client)
 	ret = devm_regulator_get_enable(dev, "vdd");
 	if (ret)
 		return dev_err_probe(dev, ret,
-				"can't get and enable vdd supply\n");
+				     "can't get and enable vdd supply\n");

 	ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
 				       &data->pmin);
@@ -379,42 +376,44 @@ static int mpr_probe(struct i2c_client *client)

 	/* use 64 bit calculation for preserving a reasonable precision */
 	scale = div_s64(((s64)(data->pmax - data->pmin)) * NANO,
-						data->outmax - data->outmin);
+			data->outmax - data->outmin);
 	data->scale = div_s64_rem(scale, NANO, &data->scale2);
 	/*
 	 * multiply with NANO before dividing by scale and later divide by NANO
 	 * again.
 	 */
 	offset = ((-1LL) * (s64)data->outmin) * NANO -
-			div_s64(div_s64((s64)data->pmin * NANO, scale), NANO);
+		  div_s64(div_s64((s64)data->pmin * NANO, scale), NANO);
 	data->offset = div_s64_rem(offset, NANO, &data->offset2);

 	if (data->irq > 0) {
 		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
-				IRQF_TRIGGER_RISING, client->name, data);
+				       IRQF_TRIGGER_RISING,
+				       client->name,
+				       data);
 		if (ret)
 			return dev_err_probe(dev, ret,
-				"request irq %d failed\n", data->irq);
+					  "request irq %d failed\n", data->irq);
 	}

 	data->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
-							GPIOD_OUT_HIGH);
+						    GPIOD_OUT_HIGH);
 	if (IS_ERR(data->gpiod_reset))
 		return dev_err_probe(dev, PTR_ERR(data->gpiod_reset),
-						"request reset-gpio failed\n");
+				     "request reset-gpio failed\n");

 	mpr_reset(data);

 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
-						mpr_trigger_handler, NULL);
+					      mpr_trigger_handler, NULL);
 	if (ret)
 		return dev_err_probe(dev, ret,
-					"iio triggered buffer setup failed\n");
+				     "iio triggered buffer setup failed\n");

 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		return dev_err_probe(dev, ret,
-					"unable to register iio device\n");
+				     "unable to register iio device\n");

 	return 0;
 }
--
2.41.0


